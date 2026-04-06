import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/async_guard.dart';
import '../../providers/auth_provider.dart';
import '../../providers/business_provider.dart';
import '../../screens/auth/login/auth_branded_header.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final auth = context.read<AuthProvider>();
      final ok = await AsyncGuard.withTimeout(
        auth.loginWithPhone(_phoneCtrl.text.trim(), phoneRole: UserType.customer),
      );
      if (!mounted) return;
      if (ok) {
        Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
      } else {
        _snack('Invalid phone number');
      }
    } catch (e) {
      if (!mounted) return;
      _snack(AsyncGuard.friendlyMessage(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _RoleLoginScaffold(
      headline: 'Customer Login',
      tagline: 'Enter your registered phone number to continue',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              label: AppStrings.phone,
              hint: '03xx xxxxxxx',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_outlined,
              validator: (v) =>
                  (v ?? '').trim().length >= 10 ? null : 'Enter a valid phone number',
            ),
            const SizedBox(height: 22),
            CustomButton(
              label: 'Continue',
              onPressed: _submit,
              isLoading: _busy,
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessLoginScreen extends StatefulWidget {
  const BusinessLoginScreen({super.key});

  @override
  State<BusinessLoginScreen> createState() => _BusinessLoginScreenState();
}

class _BusinessLoginScreenState extends State<BusinessLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final auth = context.read<AuthProvider>();
      final ok = await AsyncGuard.withTimeout(
        auth.login(_emailCtrl.text.trim(), _passwordCtrl.text),
      );
      if (!mounted) return;
      if (!ok) {
        _snack('Invalid credentials');
        return;
      }

      final business = context.read<BusinessProvider>();
      await AsyncGuard.withTimeout(business.loadBusiness());
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        business.selectedBusiness == null
            ? AppRoutes.businessSelection
            : AppRoutes.dashboard,
      );
    } catch (e) {
      if (!mounted) return;
      _snack(AsyncGuard.friendlyMessage(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _RoleLoginScaffold(
      headline: 'Business Login',
      tagline: 'Owner account — sign in with email and password',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              label: AppStrings.email,
              hint: 'you@example.com',
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: (v) =>
                  (v ?? '').contains('@') ? null : 'Enter a valid email',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: AppStrings.password,
              hint: 'At least 6 characters',
              controller: _passwordCtrl,
              isPassword: true,
              prefixIcon: Icons.lock_outline_rounded,
              validator: (v) =>
                  (v ?? '').length >= 6 ? null : 'Minimum 6 characters',
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(AppStrings.forgotPassword),
              ),
            ),
            const SizedBox(height: 8),
            CustomButton(
              label: AppStrings.login,
              onPressed: _submit,
              isLoading: _busy,
            ),
          ],
        ),
      ),
    );
  }
}

class RiderLoginScreen extends StatefulWidget {
  const RiderLoginScreen({super.key});

  @override
  State<RiderLoginScreen> createState() => _RiderLoginScreenState();
}

class _RiderLoginScreenState extends State<RiderLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final auth = context.read<AuthProvider>();
      final ok = await AsyncGuard.withTimeout(
        auth.loginWithPhone(_phoneCtrl.text.trim(), phoneRole: UserType.rider),
      );
      if (!mounted) return;
      if (ok) {
        Navigator.pushReplacementNamed(context, AppRoutes.riderHome);
      } else {
        _snack('Invalid phone number');
      }
    } catch (e) {
      if (!mounted) return;
      _snack(AsyncGuard.friendlyMessage(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _RoleLoginScaffold(
      headline: 'Rider Login',
      tagline: 'Delivery partner — phone number access',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              label: AppStrings.phone,
              hint: '03xx xxxxxxx',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_outlined,
              validator: (v) =>
                  (v ?? '').trim().length >= 10 ? null : 'Enter a valid phone number',
            ),
            const SizedBox(height: 22),
            CustomButton(
              label: 'Continue',
              onPressed: _submit,
              isLoading: _busy,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeServicesLoginScreen extends StatefulWidget {
  const HomeServicesLoginScreen({super.key});

  @override
  State<HomeServicesLoginScreen> createState() =>
      _HomeServicesLoginScreenState();
}

class _HomeServicesLoginScreenState extends State<HomeServicesLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final auth = context.read<AuthProvider>();
      final ok = await AsyncGuard.withTimeout(
        auth.loginWithPhone(
          _phoneCtrl.text.trim(),
          phoneRole: UserType.serviceWorker,
        ),
      );
      if (!mounted) return;
      if (ok) {
        Navigator.pushReplacementNamed(context, AppRoutes.serviceWorkerHome);
      } else {
        _snack('Invalid phone number');
      }
    } catch (e) {
      if (!mounted) return;
      _snack(AsyncGuard.friendlyMessage(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _RoleLoginScaffold(
      headline: 'Home Services',
      tagline: 'Service worker — sign in with your phone',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              label: AppStrings.phone,
              hint: '03xx xxxxxxx',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_outlined,
              validator: (v) =>
                  (v ?? '').trim().length >= 10 ? null : 'Enter a valid phone number',
            ),
            const SizedBox(height: 22),
            CustomButton(
              label: 'Continue',
              onPressed: _submit,
              isLoading: _busy,
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleLoginScaffold extends StatelessWidget {
  const _RoleLoginScaffold({
    required this.headline,
    required this.tagline,
    required this.child,
  });

  final String headline;
  final String tagline;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthBrandedHeader(
            topPadding: topPad,
            headline: headline,
            tagline: tagline,
            bottomPadding: 32,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
              child: Material(
                color: AppColors.surface,
                elevation: 10,
                shadowColor: AppColors.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(22),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
