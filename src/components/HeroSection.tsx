import FadeUpWrapper from "./FadeUpWrapper";
import AudioToggle from "./AudioToggle";

export default function HeroSection() {
  return (
    <section className="min-h-screen flex flex-col justify-center items-center bg-[url('/bg-luxeevents.png')] bg-cover text-center px-4">
      <FadeUpWrapper>
        <h1 className="text-4xl md:text-6xl font-bold mb-4 text-white drop-shadow-lg">Événements haut de gamme</h1>
        <p className="text-lg md:text-xl text-white/80 mb-6">Le luxe à la portée de tous.</p>
        <button className="px-6 py-3 rounded-full bg-white text-black font-medium hover:bg-yellow-300 transition">Demander un devis</button>
        <AudioToggle />
      </FadeUpWrapper>
    </section>
  );
}
