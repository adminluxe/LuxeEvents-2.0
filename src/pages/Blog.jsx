import React from 'react';
import { Helmet } from 'react-helmet';
import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';
import Link from 'next/link'; // ou react-router
export default function Blog() {
  const postsDir = path.join(process.cwd(), 'content/blog');
  const files = fs.readdirSync(postsDir).filter(f => f.endsWith('.md'));
  const posts = files.map(filename => {
    const { data } = matter(fs.readFileSync(path.join(postsDir, filename)));
    return { slug: filename.replace('.md',''), title: data.title, date: data.date };
  });
  return (
    <>
      <Helmet>
        <title>Blog | LuxeEvents</title>
        <meta name="description" content="Les dernières tendances événementielles, études de cas et conseils pro par LuxeEvents." />
      </Helmet>
      <main className="prose mx-auto p-8">
        <h1>Blog</h1>
        <ul>
          {posts.map(p => (
            <li key={p.slug}>
              <Link to={`/blog/${p.slug}`}>{p.title}</Link> — <em>{p.date}</em>
            </li>
          ))}
        </ul>
      </main>
    </>
  );
}
