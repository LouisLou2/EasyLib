import 'package:easy_lib/constant/app_pic.dart';
import 'package:easy_lib/constant/app_string.dart';
import 'package:easy_lib/constant/app_style/app_color.dart';
import 'package:easy_lib/constant/app_style/app_style.dart';
import 'package:easy_lib/gui/widget/gradient_background.dart';
import 'package:easy_lib/gui/widget/named_divider.dart';
import 'package:easy_lib/service/model_state_manager.dart';
import 'package:easy_lib/util/format_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatefulWidget{
  const SignInPage({Key? key}): super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //使用它，可以在表单组件的外部使用表单状态
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> pwdVisibleNotifier = ValueNotifier(true);
  bool idenValid=false;
  bool pwdValid=false;

  late final TextEditingController idenController;
  late final TextEditingController pwdController;

  void initializeControllers() {
    //listener在文本更改时会被调用
    idenController = TextEditingController()
      ..addListener(controllerListener);
    pwdController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    idenController.dispose();
    pwdController.dispose();
  }

  bool allFieldValid(){
    print('allFieldValid');
    return idenValid && pwdValid;
    //或者使用_formKey.currentState.validate()来验证表单
  }

  String? validateEmail(String? value){
    print('validateEmail');
    if(value==null||value.isEmpty){
      idenValid=false;
      return AppStrings.pleaseEnterEmailAddress;
    }else if(FormatTool.isEmailValid(value)){
      idenValid=false;
      return AppStrings.invalidEmailAddress;
    }
    idenValid=true;
    return null;
  }
  String? validatePwd(String? value){
    print('validatePwd');
    if(value==null||value.isEmpty){
      pwdValid=false;
      return AppStrings.pleaseEnterPassword;
    }else if(FormatTool.isPwdValid(value)){
      pwdValid=false;
      return AppStrings.invalidPassword;
    }
    pwdValid=true;
    return null;
  }
  void controllerListener() {
    //validate此方法是结合表单所有validator得出的结果，返回true或false
    _formKey.currentState?.validate();
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const GradientBackground(
            children:[
              Text(
                AppStrings.login,
                style:AppStyles.titleLarge
              ),
              SizedBox(height: 6),
              Text(
                AppStrings.signInToYourAccount,
                style: AppStyles.bodySmall
              )
            ]
          ),
          Form(
            key:_formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: AppStrings.email,
                      hintText: AppStrings.email,
                      prefixIcon: Icon(Icons.email),
                      border: AppStyles.textFormFieldBorder
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: idenController,
                    validator: validateEmail,
                  ),
                  ValueListenableBuilder(
                    valueListenable: pwdVisibleNotifier,
                    builder: (_, pwdObscure, __)=>TextFormField(
                      obscureText: pwdObscure,
                      controller: pwdController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      validator: validatePwd,
                      //onChanged: (_) => _formKey.currentState?.validate(),
                      decoration: InputDecoration(
                        labelText: AppStrings.password,
                        hintText: AppStrings.password,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            pwdObscure ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                            size: 20,
                          ),
                          onPressed: () => pwdVisibleNotifier.value = !pwdObscure,
                          style: IconButton.styleFrom(
                            minimumSize: const Size.square(48),
                          ),
                        ),
                        border: AppStyles.textFormFieldBorder,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){},
                    child: const Text(
                        AppStrings.forgotPassword
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: ()=>{allFieldValid()?ModelStateManager.loginAndNav():null},
                    child: const Text(AppStrings.login),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  NamedDivider(
                    name: AppStrings.orLoginWith,
                    dividerHeight: 1,
                    dividerColor: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: (){},
                          icon: SvgPicture.asset(AppPic.google, width: 14),
                          label: const Text(
                              AppStrings.facebook,
                              style: TextStyle(color: Colors.black)
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: (){},
                          icon: SvgPicture.asset(AppPic.facebook, width: 14),
                          label: const Text(
                            AppStrings.facebook,
                            style: TextStyle(color: Colors.black)
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.doNotHaveAnAccount,
                        style: AppStyles.bodySmall.copyWith(color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: (){},
                        child: Text(
                          AppStrings.register,
                          style: AppStyles.bodySmall.copyWith(color: AppColors.blue2),
                        ),
                      ),
                    ],
                  )
                ]
              )
            )
          )
        ],
      ),
    );
  }
}