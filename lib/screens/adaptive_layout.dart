import 'package:cupertino_ui/cupertino_ui.dart';

import 'contact_groups.dart';
import 'contacts.dart';

const largeScreenMinWidth = 600;

// This is a StatefulWidget because the adaptive layout eventually manages which contact group is currently selected.
class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  int selectedListId = 0;

  void _onContactListSelected(int listId) {
    setState(() {
      selectedListId = listId;
    });
  }

  @override
  Widget build(BuildContext context) {
    //The LayoutBuilder widget provides information about the parent's size constraints.
    // In the builder callback, you receive aBoxConstraints object that tells you
    // the maximum available width and height.
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > largeScreenMinWidth;

        if (isLargeScreen) {
          return _buildLargeScreenLayout();
        } else {
          return const ContactGroupsPage();
        }
      },
    );
  }


// The large screen layout uses a Row to place the sidebar and details side-by-side.
// SafeArea ensures that the content doesn't overlap with system UI elements like the status bar.
  Widget _buildLargeScreenLayout() {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 320,
              child: ContactGroupsSidebar(
                selectedListId: selectedListId,
                onListSelected: _onContactListSelected,
              ),
            ),
            Container(width: 1, color: CupertinoColors.separator),
            Expanded(child: ContactListDetail(listId: selectedListId)),
          ],
        ),
      ),
    );
  }
}
