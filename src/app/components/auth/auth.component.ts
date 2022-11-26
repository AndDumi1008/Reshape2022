import { Component, OnInit } from '@angular/core';
import {AuthService} from "../../services/auth.service";
import {AbstractControl, FormControl, FormGroup, ValidationErrors, ValidatorFn, Validators} from "@angular/forms";
import {Router} from "@angular/router";

@Component({
  selector: 'app-auth',
  templateUrl: './auth.component.html',
  styleUrls: ['./auth.component.css']
})
export class AuthComponent implements OnInit {
  profileForm = new FormGroup({
    name: new FormControl('', Validators.required),
    email: new FormControl('', [Validators.required, Validators.email]),
    password: new FormControl('', [Validators.required, Validators.minLength(8), Validators.pattern('^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)$'),  matchValidator('confirmPassword', true)]),
    confirmPassword: new FormControl('', [Validators.required, matchValidator('password')])
  });

  isChecked: boolean = false;

  constructor(private authService: AuthService, private router: Router) { }

  ngOnInit(): void {
  }

  clicked() {
    this.isChecked = !this.isChecked;
  }

  submit() {
    if(this.isChecked && this.profileForm.valid) {
      this.authService.signUp(this.profileForm.value.email!, this.profileForm.value.password!, this.profileForm.value.name!);
      this.router.navigate(['/home']);
    }
  }

  redirect() {
    this.router.navigate(['/logIn']);
  }
}

function matchValidator(
  matchTo: string,
  reverse?: boolean
): ValidatorFn {
  return (control: AbstractControl):
    ValidationErrors | null => {
    if (control.parent && reverse) {
      const c = (control.parent?.controls as any)[matchTo] as AbstractControl;
      if (c) {
        c.updateValueAndValidity();
      }
      return null;
    }
    return !!control.parent &&
    !!control.parent.value &&
    control.value ===
    (control.parent?.controls as any)[matchTo].value
      ? null
      : { matching: true };
  };
}
