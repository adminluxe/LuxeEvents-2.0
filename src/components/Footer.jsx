export default function Footer() {
  return (
    <footer className="py-8 text-center text-sm text-gray-600">
      <p>© {new Date().getFullYear()} LuxeEvents. Tous droits réservés.</p>
      <div className="mt-2 space-x-4">
        <a href="https://instagram.com" target="_blank" rel="noreferrer">Instagram</a>
        <a href="https://linkedin.com" target="_blank" rel="noreferrer">LinkedIn</a>
      </div>
    </footer>
  );
}
