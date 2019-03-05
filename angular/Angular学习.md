# Angular学习
- Concept
  - Modules
    - @NgModule
      - declarations
      - imports
      - providers
      - exports
      - bootstrap
  - Components
    - @Component
      - selector
      - templateUrl
      - providers
  -  Service
    - @Injectable
      - providedIn
  - Templates
    - {{ interpolated_value [| pipe] }}
    - [] (data => view)
    - () (view => data)
    - *ngIf="isTrue" / *ngFor="let item of list;"
    - #var 
    - @Input @Output(EventEmitter)
    - [attr.atrName]="attrValue"
    - [class.special]="isSpecial"
    - [style.styleName]="sytleValue"
    - ?.
      ```html
      <img [src]="heroImageUrl" *ngIf="isShow">
      <div [class.special]="isSpecial"></div>
      <button (click)="onSave()"></button>
      <input [(ngModule)]="name">
      <button [attr.aria-liable]="help">help</buton>
      <div [style.color]="isSpcial ? 'red':'green'"></div>
      <div [ngSwitch]="dayOfWeek">
        <span *ngSwitchCase="'Monday'">Monday</span>
        <span *ngSwitchCase="'Tuesday'">Tuesday</span>
        <span *ngSwitchDefault>...</span>
      </div>
      <input #phone value="" placeholder="Phone number">
      <span> {{ phone.value }}</span>
      <h2>{{ domain?name }}</h2>
      ```
- ReactiveFormsModule
  ```typescript
  // 导入模块 app/app.module.ts
  import { ReactiveFormsModule } from '@angular/forms';
  @NgModule({
  // ...
  imports: [
    ReactiveFormsModule,
  ]
  // ...
  })
  export class AppModule { }
  // 1.FormControl
  import { FormControl } from '@angrlar/forms';
  export class FormComponent {
    name = new FormControl('');
  }
  // 模板中绑定
  // <input type="text" [formControl]="name">
  // 2.FormGroup
  import { FormControl, FormGroup } from '@angrlar/forms';
  export class FormComponent {
    profileFormGroup = new FormGroup(
      firstName: new FormControl(''),
      lastName: new FormControl(''),
    )
  }
  // formGroup值和方法
  //  formGroup.status
  //  formGroup.setValue()
  //  formGroup.patchValue()
  // 模板关联
  // <form [formGroup]="profileFormGroup" (ngSubmit)="onSubmit()">
  //  <input type="text" formControlName="firstName">
  //  <input type="text" formCOntrolName="lastName">
  //  <div formGroupName="address">
  //    <input type="text" formControlName="">
  //  </div>
  // </form>
  //  3.FormBuilder
  //      control()
  //      group()
  //      array()
  import { FormBuilder } from '@angrlar/forms';
  export class FormComponent {
    profileFormGroup = this.formBuilder.group(
      firstName: [''],
      lastName: [''],
    )
    constructor(private formBuilder: FormBuilder) { }
  }
  //  4.FormArray
  import { FormControl, FormArray, FormBuilder } from '@angrlar/forms';
  export class FormComponent {
    profileFormGroup = this.formBuilder.group(
      firstName: ['', FormBuilder.required],
      lastName: [''],
      alias: this.formBuilder.array([
        this.formBuilder.control(''),
      ]),
    )
    constructor(private formBuilder: FormBuilder) { }
  }
  //  formArray方法
  //    push
  // 模板绑定
  // <form formArray="aliases">
  //  <div *ngFor="let address of aliases.controls; let i=index">
  //    <input type="text" [formControlName]="i">
  //  </div>
  // 表单验证
  import { FormBuilder, Validators } from '@angrlar/forms';
  export class FormComponent {
    profileFormGroup = this.formBuilder.group(
      firstName: ['', FormBuilder.required],
      lastName: [''],
    )
    constructor(private formBuilder: FormBuilder) { }
  }
  // 自定义Validator
  export function forbiddenNameValidator(nameRe: RegExp): {
    return (control: AbstractControl): {[key: string]: any} | null => {
      const forbidden = nameRef.test(control.value);
      return forbidden ? {'forbiddenName'; {value: control.value}} : null;
    }
  }
  // 异步验证
  //  AsyncValidatorFn / AsyncValidator
  // CSS
  //  .ng-valid / .ng-invalid
  //  .ng-pending / .ng-pristine
  //  .ng-dirty
  //  .ng-touched / .nguntouched
  ```
- HttpClientModule
  ```typescript
  // 导入模块 app/app.module.ts
  { HttpClientModule } form '@angular/common/http';
  @NgModule({
    // ...
    imports: [
      HttpClientModule,
    ]
    // ...
  })
  export class AppModule { }
  // 注入服务
  import { HttpClient } from '@angular/common/http';
  export class HttpService {
      constructor(private httpClient: HttpClient) { }
  }
  // 使用
  this.httpClient.get(this.httpStarterGetUrl, {responseType: 'text'});
  // 拦截器编写
  import { HttpEvent, HttpInterceptor, HttpHandler, HttpRequest } from '@angular/common/http';
  export class NoopInterceptor implements HttpInterceptor {
    intercept(req: HttpRequest<any>, next: HttpHandler):
      Observable<HttpEvent<any>> {
      return next.handle(req);
    }
  }
  // 组合
  export const httpInterceptorProviders = [
    { provide: HTTP_INTERCEPTORS, useClass: NoopInterceptor, multi: true },
  ];
  // 提供 app/app.module.ts (interceptor providers)
  @NgModule({
    // ...
    providers: [
      httpInterceptorProviders
    ]
    // ...
  })
  export class AppModule { }
  ```
- Router
  ```typescript
  // index.html
  // <base href="/">
  // 申明路由 app/app-routing.module.ts
  import { Routes, RouterModule } from '@angular/router';
  const appRoutes: Routes = [
    {path: 'hello', component: HelloComponent},
    {path: '', redirectTo: '/home', pathMatch: 'full'},
    {path: '**', component: PageNotFoundComponent}
  ];
  @NgModule({
    imports: [RouterModule.forRoot(appRoutes, {enableTracing: false})],
    exports: [RouterModule]
  })
  export class AppRoutingModule { }
  // 导入模块 app/app.module.ts
  import { AppRoutingModule }        from './app-routing.module';
  @NgModule({
    // ...
    imports: [
      AppRoutingModule
    ]
    // ...
  })
  export class AppModule { }
  // 路由出口
  // <router-outlet></router-outlet>
  // 路由连接
  // <a routerLink="/hello" routerLinkActive="active">hello</a>
  // 路由服务注入
  //    Router
  //        routerState 
  //    ActivatedRoute
  //        url
  //        data
  //        paramMap
  //        queryParamMap
  //        fragment
  //        outlet
  //        routeConfig
  //        parent
  //        firstChild
  //        children
  //  路由参数
  //   this.hero$ = this.activatedRoute.paramMap.pipe(
  //    switchMap((params: ParamMap) =>
  //    this.service.getHero(params.get('id')));
  //  导航
  //    this.router.navigate(['/heroes']);
  // 路由守卫
  //  CanActivate:  navigation to a route
  //  CanActiveChild:  navigation to a child route
  //  CanDeactive: navigation away from the current route
  //  Resolve:  route data retrieval before route activatio
  //  CanLoad: navigation to a feature module loaded asynchronously
  ```
- BrowserAnimationsModule
  ```typescript
  // 导入模块 app/app.module.ts
  import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
  @NgModule({
    imports: [
      BrowserAnimationsModule,
    ],
    declarations: [ ],
    bootstrap: [ ]
  })
  export class AppModule { }
  // 导入动画
  import {
    trigger,
    state,
    style,
    animate,
    transition,
    // ...
  } from '@angular/animations';
  @Component({
    selector: 'app-root',
    templateUrl: 'app.component.html',
    styleUrls: ['app.component.css'],
    animations: [
      // animation triggers go here
    ]
  })
  // transition(state, animate('duration delay easing'));
  // trigger() 
  ```
- ng命令
    ```bash
    ng new angular-starter --routing --style=css --skipTests --force
    ng generate component / service / class / pipe / module --skipTests
    ng serve --open
    ```