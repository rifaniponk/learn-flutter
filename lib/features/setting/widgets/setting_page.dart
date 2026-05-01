import 'package:flutter/material.dart';

import '../../../app/tokens.dart';
import '../../../shared/widgets/ui/ui.dart';

/// A small showcase of the new design system. This page is intentionally
/// busy so you can see Buttons, Cards, Chips, and Inputs in one place.
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(AppTokens.space5),
      children: [
        // Header
        Text('Make it yours', style: textTheme.displaySmall),
        const SizedBox(height: AppTokens.space2),
        Text(
          'A quick tour of the new design system.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: AppTokens.space6),

        // Buttons section
        Text('Buttons', style: textTheme.titleMedium),
        const SizedBox(height: AppTokens.space3),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppButton(
                label: 'Primary action',
                icon: Icons.bolt_rounded,
                onPressed: () {},
                fullWidth: true,
              ),
              const SizedBox(height: AppTokens.space3),
              AppButton(
                label: 'Soft / secondary',
                variant: AppButtonVariant.soft,
                onPressed: () {},
                fullWidth: true,
              ),
              const SizedBox(height: AppTokens.space3),
              AppButton(
                label: 'Outline',
                variant: AppButtonVariant.outline,
                onPressed: () {},
                fullWidth: true,
              ),
              const SizedBox(height: AppTokens.space3),
              AppButton(
                label: 'Delete account',
                icon: Icons.delete_outline,
                variant: AppButtonVariant.danger,
                onPressed: () {},
                fullWidth: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTokens.space6),

        // Chips
        Text('Chips', style: textTheme.titleMedium),
        const SizedBox(height: AppTokens.space3),
        const AppCard(
          child: Wrap(
            spacing: AppTokens.space2,
            runSpacing: AppTokens.space2,
            children: [
              AppChip(label: 'Default'),
              AppChip.accent(label: 'Featured', icon: Icons.star_rounded),
              AppChip.success(label: 'Active', icon: Icons.check_rounded),
              AppChip(label: 'Selected', selected: true),
            ],
          ),
        ),
        const SizedBox(height: AppTokens.space6),

        // Inputs
        Text('Inputs', style: textTheme.titleMedium),
        const SizedBox(height: AppTokens.space3),
        AppCard(
          child: Column(
            children: [
              AppTextField(
                label: 'Display name',
                hint: 'How should we call you?',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: AppTokens.space4),
              AppTextField(
                label: 'Email',
                hint: 'you@example.com',
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTokens.space6),

        // Card variants
        Text('Cards', style: textTheme.titleMedium),
        const SizedBox(height: AppTokens.space3),
        const AppCard(
          variant: AppCardVariant.accent,
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppTokens.orange700),
              SizedBox(width: AppTokens.space3),
              Expanded(
                child: Text(
                  'Accent cards are great for tips, callouts, and onboarding hints.',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTokens.space3),
        AppCard(
          variant: AppCardVariant.flat,
          child: Row(
            children: [
              Icon(Icons.layers_outlined, color: AppTokens.ink500),
              const SizedBox(width: AppTokens.space3),
              Expanded(
                child: Text(
                  'Flat cards sit quietly in the background.',
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTokens.space12),
      ],
    );
  }
}
