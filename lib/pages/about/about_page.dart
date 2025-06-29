import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 90.0,
                backgroundImage: NetworkImage(
                  'https://media.licdn.com/dms/image/v2/D5603AQHi5-xyeqC3Uw/profile-displayphoto-shrink_800_800/B56ZSUPUrKGoAc-/0/1737653833105?e=1756339200&v=beta&t=EnSpElDqicPLVZ5W_V2lxNtLduIIIClRlohEYCUyrmo',
                ),
              ),
              const SizedBox.square(dimension: 24),
              Text(
                'Reyvaldo Shiva Pramudya',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      launchUrl(Uri.https('instagram.com', '/reyvaldoshipra'));
                    },
                    icon: FaIcon(FontAwesomeIcons.instagram),
                  ),
                  IconButton(
                    onPressed: () {
                      launchUrl(
                        Uri.https('github.com', '/reyvaldoshivapramudya'),
                      );
                    },
                    icon: FaIcon(FontAwesomeIcons.github),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
