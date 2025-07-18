// src/layouts/Layout.jsx
import TopBarControls from "@/components/TopBarControls";

export default function Layout({ children }) {
  return (
    <div
      className="min-h-screen h-screen w-full scroll-snap-y overflow-y-scroll relative bg-cover bg-center bg-no-repeat"
      style={{ backgroundImage: "url('/media/images/luxeevents-bg-hero.webp')" }}
    >
      <div className="absolute inset-0 bg-black/60 z-0" />
      <TopBarControls />
      <main className="relative z-10">{children}</main>
    </div>
  );
}
