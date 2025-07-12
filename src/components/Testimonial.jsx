export default function Testimonial({ quote = '', author = '' }) {
  return (
    <section className="py-16 bg-gray-100 text-center">
      <blockquote className="italic text-xl max-w-2xl mx-auto">“{quote}”</blockquote>
      <p className="mt-4 font-semibold">— {author}</p>
    </section>
  );
}
