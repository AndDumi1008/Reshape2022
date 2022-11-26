import {IAppwriteConfig} from "./appwrite.interface";

export interface IEnvironment {
  production: boolean;
  appwrite: IAppwriteConfig;
  apiUrl: string;
}
