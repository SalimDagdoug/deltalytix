// Test database connection script
// Run with: npx ts-node scripts/test-db-connection.ts

import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  console.log('🔄 Testing database connection...\n')
  
  try {
    // Test basic connection
    await prisma.$connect()
    console.log('✅ Successfully connected to the database!\n')
    
    // Test a simple query
    const result = await prisma.$queryRaw`SELECT NOW() as current_time, current_database() as database`
    console.log('📊 Database info:', result)
    
    // Count users (if any)
    const userCount = await prisma.user.count()
    console.log(`👥 Total users in database: ${userCount}`)
    
    // Count trades (if any)
    const tradeCount = await prisma.trade.count()
    console.log(`📈 Total trades in database: ${tradeCount}`)
    
    console.log('\n🎉 All connection tests passed!')
    
  } catch (error) {
    console.error('❌ Connection failed:', error)
    process.exit(1)
  } finally {
    await prisma.$disconnect()
  }
}

main()
