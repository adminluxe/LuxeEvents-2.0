import Layout from "@/layouts/Layout";
import React from 'react';

export default function ServicesPage() {
  return (
    <Layout>
    <div className="p-8 text-center">
      <h1 className="text-3xl sm:text-4xl font-bold text-center text-yellow-600 hover:scale-105 transition-transform duration-500 shadow-md hover:shadow-yellow-300 font-semibold text-yellow-600">Nos Services</h1>
      <p className="mt-4 text-gray-700">
        Organisation complète, coordination, décoration, et plus encore.
      </p>
    </div>
  );
}
