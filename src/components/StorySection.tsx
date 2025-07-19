import SwiperStory from "./SwiperStory";
import Timeline from "./Timeline";

export default function StorySection() {
  return (
    <section className="bg-black text-white py-20 px-4 space-y-16">
      <SwiperStory />
      <Timeline />
    </section>
  );
}
