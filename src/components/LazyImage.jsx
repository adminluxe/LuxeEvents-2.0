"use client";

export default function LazyImage({ filename, alt }) {
  return (
    <img
      src={`/images/story/thumbs-600/${filename}`}
      srcSet={`
        /images/story/thumbs-300/${filename} 300w,
        /images/story/thumbs-600/${filename} 600w,
        /images/story/${filename} 1280w
      `}
      sizes="(max-width: 768px) 300px, (max-width: 1280px) 600px, 1280px"
      alt={alt}
      loading="lazy"
      className="w-full h-auto rounded"
    />
  );
}
