import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {IAvatar} from "../interfaces/avatar.interface";
import {IAvatarDetails} from "../interfaces/avatar-details.interface";

@Injectable({
  providedIn: 'root'
})
export class AvatarService {

  private readonly apiUrl = environment.apiUrl;
  constructor(private http: HttpClient) { }

  getAvatars(): Observable<IAvatar[]> {
    return this.http.get<IAvatar[]>(`${this.apiUrl}api/`);
  }

  getAvatarByID(id: string): Observable<IAvatarDetails> {
    return this.http.get<IAvatarDetails>(`${this.apiUrl}api/${id}`);
  }
}
