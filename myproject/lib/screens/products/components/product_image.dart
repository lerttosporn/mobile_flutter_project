import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myproject/utils/constant.dart';

class ProductImage extends StatefulWidget {
  final Function(
    File? file, [
    //ใช้กับ Web
    String? webImageUrl,
  ])
  callBackSetImage;
  final String? imageUrl; // rename from `image` เพื่อความชัดเจน

  const ProductImage(
    this.callBackSetImage, {
    required this.imageUrl,
    super.key,
  });

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  File? _imageFile;
  String? _webImagePath;

  final _picker = ImagePicker();

  @override
  void dispose() {
    _imageFile?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildPickerImage(), _buildPreviewImage()],
      ),
    );
  }

  Widget _buildPreviewImage() {
    final url = widget.imageUrl;

    if ((url == null || url.isEmpty) &&
        _imageFile == null &&
        _webImagePath == null) {
      return const SizedBox();
    }

    if (kIsWeb && _webImagePath != null) {
      return Stack(
        children: [
          _reuseContainer(
            Image.network(
              _webImagePath!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          _buildDeleteImageButton(),
        ],
      );
    }

    if (_imageFile != null) {
      return Stack(
        children: [
          _reuseContainer(
            Image.file(
              _imageFile!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          _buildDeleteImageButton(),
        ],
      );
    }

    // fallback: แสดงจาก URL ที่ส่งมา (ถ้ามี)
    return _reuseContainer(
      Image.network(
        url ?? baseURLImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _reuseContainer(Widget child) {
    return Container(
      color: Colors.grey[100],
      margin: const EdgeInsets.only(top: 4),
      alignment: Alignment.center,
      height: 250,
      child: child,
    );
  }

  Center _buildPickerImage() {
    return Center(
      child: _imageFile == null && _webImagePath == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.image, size: 30),
                  onPressed: _modalPickerImage,
                ),
                const Text('เลือกรูปภาพ'),
              ],
            )
          : const SizedBox(height: 20),
    );
  }

  void _modalPickerImage() {
    ListTile buildListTile(IconData icon, String title, ImageSource src) {
      return ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          Navigator.of(context).pop();
          _pickImage(src);
        },
      );
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildListTile(Icons.photo_camera, 'ถ่ายภาพ', ImageSource.camera),
              buildListTile(
                Icons.photo_library,
                'เลือกจากคลังภาพ',
                ImageSource.gallery,
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImage(ImageSource source) {
    _picker
        .pickImage(
          source: source,
          imageQuality: 70,
          maxWidth: 500,
          maxHeight: 500,
        )
        .then((picked) {
          if (picked != null) {
            _cropImage(picked.path);
          }
        })
        .catchError((err) {
          // handle error
        });
  }

  Future<void> _cropImage(String path) async {
    // สร้าง settings สำหรับแต่ละ platform
    List<PlatformUiSettings> settings = [];

    // สำหรับ Web: ต้องให้ WebUiSettings (จำเป็น) :contentReference[oaicite:1]{index=1}
    if (kIsWeb) {
      settings.add(
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
          size: const CropperSize(width: 500, height: 500),
        ),
      );
    } else {
      // สำหรับ Android / iOS
      settings.add(
        AndroidUiSettings(
          toolbarTitle: 'ครอบรูป',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
      );
      settings.add(
        IOSUiSettings(title: 'ครอบรูป', aspectRatioLockEnabled: false),
      );
    }

    final cropped = await ImageCropper().cropImage(
      sourcePath: path,
      maxWidth: 500,
      maxHeight: 500,
      uiSettings: settings,
    );

    if (cropped != null && mounted) {
      setState(() {
        if (kIsWeb) {
          _webImagePath = cropped.path;
          widget.callBackSetImage(null, _webImagePath); // <-- ใส่ตรงนี้
        } else {
          _imageFile = File(cropped.path);
          widget.callBackSetImage(_imageFile);
        }
      });
    }
  }

  Positioned _buildDeleteImageButton() {
    return Positioned(
      right: -10,
      top: 10,
      child: RawMaterialButton(
        onPressed: _deleteImage,
        fillColor: Colors.white,
        shape: const CircleBorder(
          side: BorderSide(width: 1, color: Colors.grey),
        ),
        child: const Icon(Icons.clear),
      ),
    );
  }

  void _deleteImage() {
    setState(() {
      _imageFile = null;
      _webImagePath = null;
      widget.callBackSetImage(null);
    });
  }
}
