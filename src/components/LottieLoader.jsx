import React from 'react';

export default function LottieLoader() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: LottieLoader.jsx</div>
    <div className="fixed inset-0 z-50 bg-black flex items-center justify-center">
      <Lottie animationData={animationData} loop={false} className="w-64 h-64" />
    </div>



    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: LottieLoader.jsx</div>
    <div className="fixed inset-0 z-50 bg-black flex items-center justify-center">
      <Lottie animationData={animationData} loop={false} className="w-64 h-64" />
    </div>
  );
}
    </>
  );
}
