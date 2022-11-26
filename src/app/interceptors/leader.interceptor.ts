import {Injectable} from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor
} from '@angular/common/http';
import {Observable} from 'rxjs';
import {LoaderService} from "../services/loader.service";
import {finalize} from "rxjs/operators";

@Injectable()
export class LoaderInterceptor implements HttpInterceptor {
  private count = 0;

  constructor(private loaderService:LoaderService) {
  }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    if (!this.count) {
      this.loaderService.setHttpProgress(true);
    }
    this.count++;
    return next.handle(request).pipe(finalize(() => {
      this.count--;
      if (!this.count) {
        this.loaderService.setHttpProgress(false);
      }
    }))
  }
}
