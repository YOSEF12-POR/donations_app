import 'package:donations_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PYMENTSCREEN extends StatefulWidget {
  final amountController;
  final project_id;
  PYMENTSCREEN(this.amountController, this.project_id);

  @override
  State<PYMENTSCREEN> createState() => _PYMENTSCREENState();
}

class _PYMENTSCREENState extends State<PYMENTSCREEN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        onPageFinished: (page){},
        javascriptMode: JavascriptMode.unrestricted,
        
        initialUrl: 'http://46.60.64.246:5669/api/paymentsWithoutAuth/create/${widget.project_id}/${widget.amountController}',
        
      ),
    );
  }
}
// }WebView(
        
//           javascriptMode: JavascriptMode.unrestricted,
//               onWebViewCreated: (WebViewController webViewController) {
//                 Map<String, String> headers = {"Authorization": "Bearer " + token!};
//                 webViewController.loadUrl('http://188.161.30.96:5669/api/', headers: headers);
//               },
             
           
//         initialUrl: 'http://188.161.30.96:5669/api/payments/create/${widget.project_id}/${widget.amountController}',
        
//       ),

// WebView(
//         onPageFinished: (page){},
//         javascriptMode: JavascriptMode.unrestricted,
        
//         initialUrl: 'http://188.161.30.96:5669/api/paymentsWithoutAuth/create/${widget.project_id}/${widget.amountController}',
        
//       ),