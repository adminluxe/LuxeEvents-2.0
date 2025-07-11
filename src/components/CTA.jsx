import React from 'react';
export default function CTA({ text, href }) {
  return (
    <a href={href} className="inline-block px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
      {text}
    </a>
  );
}
