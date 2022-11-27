import {IMeal} from "./meal.interface";

export interface IAvatarDetails {
  id: string,
  name: string,
  level: string,
  bigUrl: string,
  shortBio: string,
  smallUrl: string,
  backgroundUrl: string,
  age: string,
  netWorth: string,
  wakeUpTime: string,
  sleepTime: string,
  mealsWeek: IMeal[],
  trainingWeek: string[]
}
