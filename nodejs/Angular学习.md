# Angular学习
- Concept
  - @NgModule
    - declarations
    - exports
    - imports
    - providers
    - bootstrap
  - @Component
    - selector
    - templateUrl
    - provder
  - @Injectable
    - providedIn
  - @Directive
    - selector
  - @Pipe
- template
  - {{}}
  - [(ngModel)]
  - [attr.atrName]="attrValue"
  - [class.special]="isSpecial" / [ngClass]
  - [style.styleName]="sytleValue" / [ngStyle]
  - (event)="onEvent($event)"
  - *ngIf="isTrue"
  - *ngFor="let item of list; trackBy: "
  - [*ngSwitch]="condition"
    - <director *ngSwitchCase="condition></director>
    - <director *ngSwitchDefault="condition></director>
  - #var
- 常用module
  - NgModule: import { NgModule } from '@angular/core';
  - CommonModule: import {CommonModule} from '@angular/common';
  - BrowserModule: import { BrowserModule } from '@angular/platform-browser';
  - FormsModule: import { FormsModule} from '@angular/forms';
  - ReactiveFormsModule: import { ReactiveFormsModule } from '@angular/forms';
    - FormControl / [formControl] / setValue
    - FormGroup / [formGroup] / formGroupName / formControlName / (ngSubmit) / setValue / patchValue
    - FormBuilder / control() / group() / array()
    - Validators
  - HttpClientModule: import {HttpClientModule} form '@angular/common/http';
  - RouterModule: import { Routes, RouterModule } from '@angular/router';
    - <a routerLink="/a"></a>
    - router-outlet
    ```typescript
    const routes: Routes = [
      {path: '/a', component: HelloComponent},
      {path: '', redirectTo: '/dashboadr', pathMatch: 'full'}
    ];
    @NgModule({
      imports: [RouterModule.forRoot(routes)],
      exports: [RouterModule]
    })
    export class AppRoutingModule { }
    ```
- 组件交互
  - 父->子
    - @Input, 父绑定到子属性
    - setter监听改变
    - ngOnChanges
  - 子->父
    - @Output
- ng命令
    ```bash
    ng new hello-angular --force
    ng serve --open
    ng generate class --skipTest
    ng generate component
    ng generate directive
    ng generate enum
    ng generate interface
    ng generate library
    ng generate module
    ng generate pipe
    ng generate service
    ```