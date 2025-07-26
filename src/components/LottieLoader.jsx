import React from 'react';

export default function LottieLoader() {
  return (
    <>
    <div className="fixed inset-0 z-50 bg-black flex items-center justify-center">
      <Lottie animationData={animationData} loop={false} className="w-64 h-64" />
    </div>



    <div className="fixed inset-0 z-50 bg-black flex items-center justify-center">
      <Lottie animationData={animationData} loop={false} className="w-64 h-64" />
    </div>
  );
}
    </>
  );
}
