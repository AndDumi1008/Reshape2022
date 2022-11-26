import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AvatarLevelColorService {

  constructor() { }

  colorPicker(level: string) {
    if(level.toLowerCase()==='easy') {
      return '#9BCC32';
    } else if(level.toLowerCase()==='medium') {
      return '#C9CC32';
    } else if(level.toLowerCase()==='hard') {
      return '#CC4432';
    } else {
      return '#32B4CC';
    }
  }
}
