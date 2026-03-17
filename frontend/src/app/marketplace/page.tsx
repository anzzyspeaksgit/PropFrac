'use client';

import Head from 'next/head';
import { ConnectButton } from '@rainbow-me/rainbowkit';
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

const mockProperties = [
  {
    id: 1,
    title: "Luxury Condo in Downtown Miami",
    image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800&q=80",
    pricePerFraction: 50,
    fractionsAvailable: 200,
    totalFractions: 1000,
    yieldAPY: "8.5%",
  },
  {
    id: 2,
    title: "Beachfront Villa in Bali",
    image: "https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?w=800&q=80",
    pricePerFraction: 100,
    fractionsAvailable: 50,
    totalFractions: 500,
    yieldAPY: "12.0%",
  },
  {
    id: 3,
    title: "Commercial Space in London",
    image: "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&q=80",
    pricePerFraction: 250,
    fractionsAvailable: 100,
    totalFractions: 1000,
    yieldAPY: "6.2%",
  }
];

export default function Marketplace() {
  return (
    <div className="min-h-screen flex flex-col relative overflow-hidden text-slate-100">
      <Head>
        <title>PropFrac | Marketplace</title>
      </Head>

      <div className="fixed inset-0 -z-10">
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-purple-500/20 rounded-full blur-[128px]" />
        <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-blue-500/20 rounded-full blur-[128px]" />
      </div>
      
      <header className="w-full bg-white/5 backdrop-blur-md p-4 flex justify-between items-center border-b border-white/10 sticky top-0 z-10">
        <h1 className="text-2xl font-bold cursor-pointer bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent" onClick={() => window.location.href='/'}>PropFrac</h1>
        <div className="flex gap-4 items-center">
            <a href="/marketplace" className="text-white hover:text-blue-300 font-medium transition-colors">Marketplace</a>
            <a href="/portfolio" className="text-gray-300 hover:text-white font-medium mr-4 transition-colors">Portfolio</a>
            <ConnectButton />
        </div>
      </header>

      <main className="flex-grow p-8 max-w-7xl mx-auto w-full z-10">
        <div className="mb-12">
            <h2 className="text-5xl font-bold bg-gradient-to-r from-white via-purple-200 to-purple-400 bg-clip-text text-transparent mb-4">Marketplace</h2>
            <p className="text-xl text-gray-400 font-light">Browse and invest in fractional real estate globally.</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {mockProperties.map((property) => (
                <Card key={property.id} className="overflow-hidden p-0 rounded-2xl bg-white/5 backdrop-blur-xl border border-white/10 hover:border-purple-500/50 transition-all duration-300 hover:shadow-2xl hover:shadow-purple-500/20 group">
                    <div className="relative h-56 w-full bg-gray-900 overflow-hidden">
                        <img 
                            src={property.image} 
                            alt={property.title} 
                            className="w-full h-full object-cover opacity-80 group-hover:opacity-100 transition-all duration-500 group-hover:scale-105"
                        />
                        <div className="absolute top-3 right-3 bg-gradient-to-r from-emerald-400 to-emerald-600 text-white px-3 py-1.5 rounded-full text-sm font-bold shadow-lg">
                            {property.yieldAPY} APY
                        </div>
                    </div>
                    <CardHeader className="pt-6">
                        <CardTitle className="text-2xl text-slate-100">{property.title}</CardTitle>
                        <CardDescription className="text-slate-400 text-sm tracking-widest uppercase">ID: {property.id}</CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                        <div className="flex justify-between items-center bg-white/5 p-3 rounded-lg border border-white/5">
                            <span className="text-slate-400 text-sm uppercase tracking-wider">Price per Fraction</span>
                            <span className="font-bold text-xl text-white">${property.pricePerFraction}</span>
                        </div>
                        <div className="flex justify-between items-center mt-4 mb-2">
                            <span className="text-slate-400 text-sm">Available</span>
                            <span className="font-medium text-purple-300">{property.fractionsAvailable} <span className="text-slate-500">/ {property.totalFractions}</span></span>
                        </div>
                        
                        <div className="w-full bg-white/10 rounded-full h-1.5 overflow-hidden">
                            <div className="bg-gradient-to-r from-blue-500 to-purple-500 h-1.5 rounded-full" style={{width: `${((property.totalFractions - property.fractionsAvailable) / property.totalFractions) * 100}%`}}></div>
                        </div>
                    </CardContent>
                    <CardFooter className="pb-6 pt-4">
                        <Button className="w-full bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-500 hover:to-purple-500 text-white font-medium shadow-lg shadow-purple-500/20 rounded-xl py-6 transition-all border-none">
                            Invest Now
                        </Button>
                    </CardFooter>
                </Card>
            ))}
        </div>
      </main>
    </div>
  );
}
