import TopBarControls from "@/components/TopBarControls";

export default function Layout({ children }) {
  return (
    <div className="bg-[url(/media/images/luxeevents-bg-hero.webp)] bg-cover bg-center min-h-screen scroll-snap-y overflow-y-scroll h-screen relative">
      <TopBarControls />
      {children}
    </div>
  );
}
