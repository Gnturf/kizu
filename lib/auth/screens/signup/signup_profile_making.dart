import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kizu/auth/components/display_subtitle_text.dart';
import 'package:kizu/welcome/components/icon_text_button.dart';

class ProfileMakingScreen extends StatefulWidget {
  const ProfileMakingScreen({
    super.key,
  });

  @override
  State<ProfileMakingScreen> createState() => _ProfileMakingScreenState();
}

class _ProfileMakingScreenState extends State<ProfileMakingScreen> {
  File? selectedImage;
  TextEditingController _controller = TextEditingController();
  String? errorText;

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
            size: 36,
          ),
          iconSize: 36,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DisplaySubtitleText(
              displayText: "Decide how you want people to see you!",
              subtitleText: "Create your profile",
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  _pickImageFromGallery();
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pick Your Image"),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
              maxLength: 20,
              decoration: InputDecoration(
                errorText: errorText,
                counterText: "",
                hintText: "What's your name?",
                hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6),
                    ),
              ),
            ),
            const Spacer(),
            IconTextButton(
              // OVER HERE!!!
              label: "Create your account",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
