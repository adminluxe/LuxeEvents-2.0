export default function Footer(){
  return (
    <footer className="mt-20 border-t py-8 text-sm">
      <div className="container mx-auto flex flex-col md:flex-row items-center justify-between gap-4">
        <p>© {new Date().getFullYear()} LuxeEvents • Luxe • Excellence • Innovation</p>
        <nav className="flex gap-4">
          <a href="/mentions-legales">Mentions légales</a>
          <a href="/privacy">Confidentialité</a>
          <a href="https://instagram.com" target="_blank" rel="noreferrer">Instagram</a>
          <a href="https://facebook.com" target="_blank" rel="noreferrer">Facebook</a>
        </nav>
      </div>
    </footer>
  );
}
