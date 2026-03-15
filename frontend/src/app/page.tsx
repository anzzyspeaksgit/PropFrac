import Head from 'next/head';
import { ConnectButton } from '@rainbow-me/rainbowkit';

export default function Home() {
  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      <Head>
        <title>PropFrac | Fractional Real Estate</title>
      </Head>
      
      <header className="w-full bg-white shadow-sm p-4 flex justify-between items-center border-b border-gray-200">
        <h1 className="text-2xl font-bold text-blue-800">PropFrac</h1>
        <ConnectButton />
      </header>

      <main className="flex-grow flex flex-col items-center justify-center p-8 text-center">
        <h2 className="text-5xl font-bold mb-4 text-gray-900">Democratizing Real Estate</h2>
        <p className="text-xl text-gray-600 mb-8 max-w-2xl">
          Invest in premium, yield-generating properties on the BNB Chain for as little as $50. Fractional ownership, daily yield.
        </p>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-4xl mx-auto w-full">
          <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
            <h3 className="text-xl font-semibold mb-3 text-gray-800">Browse Properties</h3>
            <p className="text-gray-500 mb-4">Discover curated real estate available for fractional ownership.</p>
            <button className="bg-blue-600 text-white px-6 py-2 rounded-lg font-medium hover:bg-blue-700 w-full">
              View Marketplace
            </button>
          </div>
          <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
            <h3 className="text-xl font-semibold mb-3 text-gray-800">Earn Yield</h3>
            <p className="text-gray-500 mb-4">Collect rental income proportionate to your holdings directly to your wallet.</p>
            <button className="bg-gray-100 text-gray-800 px-6 py-2 rounded-lg font-medium hover:bg-gray-200 w-full border border-gray-300">
              View Portfolio
            </button>
          </div>
        </div>
      </main>
    </div>
  );
}
