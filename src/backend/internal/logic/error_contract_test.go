package logic_test

import (
	"fmt"
	"go/ast"
	"go/parser"
	"go/token"
	"io/fs"
	"path/filepath"
	"strings"
	"testing"
)

// TestLogicErrorsUseApplicationErrors protects the logic-layer error contract
// for every current and future logic package below this directory.
func TestLogicErrorsUseApplicationErrors(t *testing.T) {
	t.Helper()

	files := 0
	err := filepath.WalkDir(".", func(path string, entry fs.DirEntry, walkErr error) error {
		if walkErr != nil {
			return walkErr
		}
		if entry.IsDir() || filepath.Ext(path) != ".go" || strings.HasSuffix(path, "_test.go") {
			return nil
		}
		files++
		return checkLogicFile(path)
	})
	if err != nil {
		t.Fatalf("scan logic packages: %v", err)
	}
	if files == 0 {
		t.Fatal("no logic source files found")
	}
}

func checkLogicFile(path string) error {
	fileSet := token.NewFileSet()
	file, err := parser.ParseFile(fileSet, path, nil, 0)
	if err != nil {
		return fmt.Errorf("parse %s: %w", path, err)
	}

	for _, declaration := range file.Decls {
		function, ok := declaration.(*ast.FuncDecl)
		if !ok || function.Body == nil || !returnsError(function) {
			continue
		}
		if err := checkFunctionReturns(path, fileSet, function); err != nil {
			return err
		}
	}
	return nil
}

func returnsError(function *ast.FuncDecl) bool {
	if function.Type.Results == nil || len(function.Type.Results.List) == 0 {
		return false
	}
	last := function.Type.Results.List[len(function.Type.Results.List)-1].Type
	identifier, ok := last.(*ast.Ident)
	return ok && identifier.Name == "error"
}

func checkFunctionReturns(path string, fileSet *token.FileSet, function *ast.FuncDecl) error {
	var contractErr error
	ast.Inspect(function.Body, func(node ast.Node) bool {
		if contractErr != nil {
			return false
		}
		if _, ok := node.(*ast.FuncLit); ok {
			return false
		}
		returnStatement, ok := node.(*ast.ReturnStmt)
		if !ok || len(returnStatement.Results) == 0 {
			return true
		}
		errorResult := returnStatement.Results[len(returnStatement.Results)-1]
		if isNilExpression(errorResult) || isApplicationErrorExpression(errorResult) {
			return true
		}
		position := fileSet.Position(returnStatement.Pos())
		contractErr = fmt.Errorf(
			"%s:%d: return error must use apperrors, got %T",
			path,
			position.Line,
			errorResult,
		)
		return false
	})
	return contractErr
}

func isNilExpression(expression ast.Expr) bool {
	identifier, ok := expression.(*ast.Ident)
	return ok && identifier.Name == "nil"
}

func isApplicationErrorExpression(expression ast.Expr) bool {
	call, ok := expression.(*ast.CallExpr)
	if !ok {
		return false
	}
	selector, ok := call.Fun.(*ast.SelectorExpr)
	if !ok {
		return false
	}
	packageName, ok := selector.X.(*ast.Ident)
	return ok && packageName.Name == "apperrors"
}
