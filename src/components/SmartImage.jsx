import React, { useState } from "react";

export default function SmartImage({
  src,
  alt = "",
  width,
  height,
  placeholderSrc,          // optionnel
  className = "",
  imgClassName = "",
}) {
  const [loaded, setLoaded] = useState(false);
  const ratio = width && height ? `${width} / ${height}` : undefined;

  return (
    <div className={`relative overflow-hidden ${className}`} style={ratio ? { aspectRatio: ratio } : undefined}>
      {!loaded && (
        placeholderSrc ? (
          <img
            src={placeholderSrc}
            alt=""
            aria-hidden="true"
            className="absolute inset-0 w-full h-full object-cover blur-lg scale-110"
          />
        ) : (
          <div className="absolute inset-0 animate-pulse bg-neutral-800" />
        )
      )}

      <img
        src={src}
        alt={alt}
        loading="lazy"
        decoding="async"
        onLoad={() => setLoaded(true)}
        className={`w-full h-full object-cover transition-all duration-500 ${imgClassName} ${
          loaded ? "opacity-100 blur-0 scale-100" : "opacity-0 blur-sm scale-105"
        }`}
      />
    </div>
  );
}
