import Head from 'next/head';

export default function Home() {
  return (
    <div className="min-h-screen bg-gray-50 flex flex-col items-center justify-center">
      <Head>
        <title>PropFrac | Fractional Real Estate</title>
      </Head>
      <main className="text-center p-8">
        <h1 className="text-5xl font-bold mb-4 text-blue-800">PropFrac</h1>
        <p className="text-xl text-gray-600 mb-8">Fractional Real Estate Investment on BNB Chain</p>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-4xl mx-auto">
          <div className="bg-white p-6 rounded-lg shadow-md border border-gray-100">
            <h2 className="text-2xl font-semibold mb-2 text-gray-800">Browse Properties</h2>
            <p className="text-gray-500">Discover premium real estate available for fractional ownership.</p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-md border border-gray-100">
            <h2 className="text-2xl font-semibold mb-2 text-gray-800">Earn Yield</h2>
            <p className="text-gray-500">Collect rental income proportionate to your token holdings automatically.</p>
          </div>
        </div>
      </main>
    </div>
  );
}
