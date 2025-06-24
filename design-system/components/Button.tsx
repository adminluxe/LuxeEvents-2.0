import React from 'react';
import clsx from 'clsx';
type ButtonProps = React.ButtonHTMLAttributes<HTMLButtonElement>;
export const Button: React.FC<ButtonProps> = ({ className, children, ...props }) => (
  <button
    className={clsx(
      'px-6 py-3 rounded-2xl shadow-lg font-medium',
      'bg-gold text-black hover:scale-105 transition-transform',
      className
    )}
    {...props}
  >
    {children}
  </button>
);
