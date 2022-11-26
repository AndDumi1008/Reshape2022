import {Injectable} from '@angular/core';
import {Observable, ReplaySubject} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class LoaderService {

  private _httpLoading = new ReplaySubject<boolean>(1);

  constructor() {
  }

  httpProgress(): Observable<boolean> {
    return this._httpLoading.asObservable();
  }

  setHttpProgress(inprogress: boolean) {
    this._httpLoading.next(inprogress);
  }

}
