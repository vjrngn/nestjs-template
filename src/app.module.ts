import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import config, { DatabaseConfig } from './config';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [config]
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory(config: ConfigService) {
        const dbConfig = config.get<DatabaseConfig>('db');
        return {
          type: dbConfig.type,
          url: dbConfig.url
        }
      }
    })
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
