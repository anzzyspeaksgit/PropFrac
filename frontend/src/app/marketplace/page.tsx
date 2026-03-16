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
    <div className="min-h-screen bg-gray-50 flex flex-col">
      <Head>
        <title>PropFrac | Marketplace</title>
      </Head>
      
      <header className="w-full bg-white shadow-sm p-4 flex justify-between items-center border-b border-gray-200 sticky top-0 z-10">
        <h1 className="text-2xl font-bold text-blue-800 cursor-pointer" onClick={() => window.location.href='/'}>PropFrac</h1>
        <div className="flex gap-4 items-center">
            <a href="/marketplace" className="text-gray-600 hover:text-blue-600 font-medium">Marketplace</a>
            <a href="/portfolio" className="text-gray-600 hover:text-blue-600 font-medium mr-4">Portfolio</a>
            <ConnectButton />
        </div>
      </header>

      <main className="flex-grow p-8 max-w-7xl mx-auto w-full">
        <div className="mb-8">
            <h2 className="text-4xl font-bold text-gray-900 mb-2">Marketplace</h2>
            <p className="text-lg text-gray-600">Browse and invest in fractional real estate globally.</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {mockProperties.map((property) => (
                <Card key={property.id} className="overflow-hidden hover:shadow-lg transition-shadow">
                    <div className="relative h-48 w-full bg-gray-200">
                        <img 
                            src={property.image} 
                            alt={property.title} 
                            className="w-full h-full object-cover"
                        />
                        <div className="absolute top-2 right-2 bg-green-500 text-white px-2 py-1 rounded text-sm font-bold shadow">
                            {property.yieldAPY} APY
                        </div>
                    </div>
                    <CardHeader>
                        <CardTitle className="text-xl">{property.title}</CardTitle>
                        <CardDescription>Property ID: {property.id}</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <div className="flex justify-between items-center mb-2">
                            <span className="text-gray-500">Price per Fraction</span>
                            <span className="font-semibold text-lg">${property.pricePerFraction}</span>
                        </div>
                        <div className="flex justify-between items-center mb-4">
                            <span className="text-gray-500">Available</span>
                            <span className="font-medium text-blue-600">{property.fractionsAvailable} / {property.totalFractions}</span>
                        </div>
                        
                        <div className="w-full bg-gray-200 rounded-full h-2.5">
                            <div className="bg-blue-600 h-2.5 rounded-full" style={{width: `${((property.totalFractions - property.fractionsAvailable) / property.totalFractions) * 100}%`}}></div>
                        </div>
                    </CardContent>
                    <CardFooter>
                        <Button className="w-full bg-blue-600 hover:bg-blue-700 text-white">Invest Now</Button>
                    </CardFooter>
                </Card>
            ))}
        </div>
      </main>
    </div>
  );
}
