import 'package:flutter/material.dart';
import 'package:vault_m/components/avatar.dart';
import 'package:vault_m/routes/password_reset.dart';
import 'package:vault_m/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: AvatarWidget(initials: 'VM'),
            ),

            const Text(
              'Welcome back!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text('ifechukwu peter', style: TextStyle(fontSize: 20)),
            SizedBox(height: 40),
            NumberPadWithBadge(
              buttonColor: Color.fromARGB(255, 241, 223, 245),
              textColor: const Color.fromARGB(255, 36, 35, 35),
              confirmButtonText: 'Unlock',
            ),
          ],
        ),
      ),
    );
  }
}

class NumberPadWithBadge extends StatefulWidget {
  final ValueChanged<String>? onInputChanged;
  final ValueChanged<String>? onConfirm;
  final String confirmButtonText;
  final Color? buttonColor;
  final Color? textColor;
  final Color? badgeColor;
  final double badgeHeight;
  final int maxInputLength;

  const NumberPadWithBadge({
    super.key,
    this.onInputChanged,
    this.onConfirm,
    this.confirmButtonText = 'Confirm',
    this.buttonColor,
    this.textColor,
    this.badgeColor,
    this.badgeHeight = 60.0,
    this.maxInputLength = 10,
  });

  @override
  State<NumberPadWithBadge> createState() => _NumberPadWithBadgeState();
}

class _NumberPadWithBadgeState extends State<NumberPadWithBadge> {
  String _currentInput = '';

  void _onNumberButtonPressed(int number) {
    if (_currentInput.length < widget.maxInputLength) {
      setState(() {
        _currentInput += number.toString();
      });
      widget.onInputChanged?.call(_currentInput);
    }
  }

  Future<void> _unlock() async {
    try {
      final data = await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).loadUserDetails();
      if (_currentInput == data?.pin) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Welcome')));
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid pin')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('login failed: ${e.toString()}')));
    } finally {
      setState(() {
        _currentInput = '';
      });
    }
  }

  // void _onClearButtonPressed() {
  //   setState(() {
  //     _currentInput = '';
  //   });
  //   widget.onInputChanged?.call(_currentInput);
  // }

  void _onBackspaceButtonPressed() {
    if (_currentInput.isNotEmpty) {
      setState(() {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      });
      widget.onInputChanged?.call(_currentInput);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonDefaultColor = widget.buttonColor ?? theme.primaryColor;
    final textDefaultColor = widget.textColor ?? Colors.white;
    final badgeDefaultColor =
        widget.badgeColor ?? theme.colorScheme.secondaryContainer;
    final badgeTextColor = theme
        .colorScheme
        .onSecondaryContainer; // Or a fixed color like Colors.black

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // The Badge Display
        Container(
          height: widget.badgeHeight,
          width: 150,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: badgeDefaultColor,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: theme.dividerColor.withOpacity(0.5)),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _currentInput.isEmpty
                    ? 'Enter pin'
                    : '*' * _currentInput.length,
                style: TextStyle(
                  fontSize: widget.badgeHeight * 0.3,
                  fontWeight: FontWeight.bold,
                  color: badgeTextColor,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),

        SizedBox(
          width: 250,
          child: GridView.builder(
            shrinkWrap: true, // Important for fitting inside Column/ScrollView
            physics:
                const NeverScrollableScrollPhysics(), // Disable grid scrolling
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.0,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 20.0,
            ),
            itemCount: 9, // Numbers 1 through 9
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, index) {
              final int number = index + 1; // Map index 0-8 to numbers 1-9
              return ElevatedButton(
                onPressed: () => _onNumberButtonPressed(number),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonDefaultColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: textDefaultColor,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // Row for 0, Backspace, and Clear buttons
        SizedBox(
          width: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onBackspaceButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 252, 171, 171),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                    ),
                    child: Icon(
                      Icons.backspace_outlined,
                      color: textDefaultColor,
                      size: 20.0,
                    ),
                  ),
                ),
                // Clear Button
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: _onClearButtonPressed,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor:
                //           Colors.red.shade400, // Different color for clear
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(28.0),
                //       ),
                //       padding: const EdgeInsets.symmetric(vertical: 18.0),
                //     ),
                //     child: Text(
                //       'Clear',
                //       style: TextStyle(
                //         fontSize: 20.0,
                //         fontWeight: FontWeight.bold,
                //         color: textDefaultColor,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 8.0),
                // Zero Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onNumberButtonPressed(0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonDefaultColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: textDefaultColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                // Backspace Button
                SizedBox(width: 70),
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),

        ElevatedButton(
          onPressed: _unlock,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 229, 200, 235),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 30.0,
            ),
          ),
          child: Icon(
            Icons.lock_open_rounded,
            color: textDefaultColor,
            size: 20.0,
          ),
        ),

        // Confirm Button
      ],
    );
  }
}
