import Head from 'next/head';
import { ConnectButton } from '@rainbow-me/rainbowkit';

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col relative overflow-hidden">
      <Head>
        <title>PropFrac | Fractional Real Estate</title>
      </Head>

      {/* Glowing background orbs */}
      <div className="fixed inset-0 -z-10">
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-purple-500/20 rounded-full blur-[128px]" />
        <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-blue-500/20 rounded-full blur-[128px]" />
      </div>
      
      <header className="w-full bg-white/5 backdrop-blur-md p-4 flex justify-between items-center border-b border-white/10 sticky top-0 z-10">
        <h1 className="text-2xl font-bold bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent">PropFrac</h1>
        <div className="flex gap-4 items-center">
            <a href="/marketplace" className="text-gray-300 hover:text-white font-medium transition-colors">Marketplace</a>
            <a href="/portfolio" className="text-gray-300 hover:text-white font-medium mr-4 transition-colors">Portfolio</a>
            <ConnectButton />
        </div>
      </header>

      <main className="flex-grow flex flex-col items-center justify-center p-8 text-center z-10">
        <h2 className="text-6xl md:text-7xl font-bold mb-6 bg-gradient-to-r from-white via-purple-200 to-purple-400 bg-clip-text text-transparent tracking-tight">
          Democratizing<br/>Real Estate
        </h2>
        <p className="text-xl text-gray-300 mb-12 max-w-2xl font-light">
          Invest in premium, yield-generating properties on the BNB Chain for as little as $50. Fractional ownership, daily yield.
        </p>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-4xl mx-auto w-full">
          <div className="p-8 rounded-2xl bg-white/5 backdrop-blur-xl border border-white/10 hover:bg-white/10 transition-all duration-300 group">
            <h3 className="text-2xl font-semibold mb-4 text-white group-hover:text-purple-300 transition-colors">Browse Properties</h3>
            <p className="text-gray-400 mb-8 font-light">Discover curated real estate available for fractional ownership.</p>
            <a href="/marketplace" className="inline-block bg-gradient-to-r from-blue-600 to-purple-600 text-white px-8 py-3 rounded-xl font-medium hover:from-blue-500 hover:to-purple-500 w-full transition-all shadow-lg shadow-purple-500/20">
              View Marketplace
            </a>
          </div>
          <div className="p-8 rounded-2xl bg-white/5 backdrop-blur-xl border border-white/10 hover:bg-white/10 transition-all duration-300 group">
            <h3 className="text-2xl font-semibold mb-4 text-white group-hover:text-blue-300 transition-colors">Earn Yield</h3>
            <p className="text-gray-400 mb-8 font-light">Collect rental income proportionate to your holdings directly to your wallet.</p>
            <a href="/portfolio" className="inline-block bg-white/10 text-white px-8 py-3 rounded-xl font-medium hover:bg-white/20 w-full border border-white/10 transition-all">
              View Portfolio
            </a>
          </div>
        </div>
      </main>
    </div>
  );
}
