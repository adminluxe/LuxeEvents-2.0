export default function FeatureList({ items = [] }) {
  return (
    <section className="py-16 grid grid-cols-1 md:grid-cols-2 gap-8 max-w-4xl mx-auto">
      {items.map(({ title, text }, i) => (
        <div key={i} className="p-6 border rounded-lg shadow-sm">
          <h2 className="text-2xl font-semibold mb-2">{title}</h2>
          <p>{text}</p>
        </div>
      ))}
    </section>
  );
}
