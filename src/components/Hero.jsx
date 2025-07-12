export default function Hero({ title = [], subtitle = '', cta }) {
  return (
    <section className="py-20 text-center">
      <h1 className="text-5xl font-bold mb-4">
        {title.map((line, i) => (
          <span key={i} className="block">{line}</span>
        ))}
      </h1>
      <p className="text-lg mb-6">{subtitle}</p>
      {cta && (
        <a href={cta.href} className="px-6 py-3 bg-gold text-black font-semibold rounded">{cta.text}</a>
      )}
    </section>
  );
}
