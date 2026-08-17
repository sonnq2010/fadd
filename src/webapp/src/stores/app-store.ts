import { create } from 'zustand'

type AppState = {
  mobileNavigationOpen: boolean
}

type AppActions = {
  closeMobileNavigation: () => void
  setMobileNavigationOpen: (open: boolean) => void
}

export type AppStore = AppState & AppActions

export const useAppStore = create<AppStore>()((set) => ({
  mobileNavigationOpen: false,
  closeMobileNavigation: () => set({ mobileNavigationOpen: false }),
  setMobileNavigationOpen: (mobileNavigationOpen) =>
    set({ mobileNavigationOpen }),
}))
