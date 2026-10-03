import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../home_sample_collection/presentation/screen/home_sample_collection_screen.dart';
// import 'package:hospital_management_system/core/constants/colors.dart';
// import 'package:hospital_management_system/core/widgets/animated_widgets.dart';
// import 'package:hospital_management_system/features/home_sample_collection/presentation/screen/home_sample_collection_screen.dart';

class LabTestCatalogScreen extends StatefulWidget {
  const LabTestCatalogScreen({Key? key}) : super(key: key);

  @override
  State<LabTestCatalogScreen> createState() => _LabTestCatalogScreenState();
}

class _LabTestCatalogScreenState extends State<LabTestCatalogScreen> {
  String _searchQuery = '';
  final Set<String> _cart = {};

  final List<Map<String, dynamic>> _labTests = [
    {
      'id': 'T1',
      'name': 'Complete Blood Count (CBC)',
      'category': 'Pathology',
      'price': 25,
      'fasting': 'No Fasting',
      'reportsIn': '6h',
      'parameters': '24 Parameters',
      'image': 'https://images.unsplash.com/photo-1579152276506-5d5ee2af8b67?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'T2',
      'name': 'Lipid Profile',
      'category': 'Cardiac',
      'price': 35,
      'fasting': '12h Fasting',
      'reportsIn': '12h',
      'parameters': '8 Parameters',
      'image': 'https://images.unsplash.com/photo-1628595351029-c2bf17511435?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'T3',
      'name': 'Liver Function Test (LFT)',
      'category': 'Pathology',
      'price': 30,
      'fasting': 'Recommended',
      'reportsIn': '8h',
      'parameters': '11 Parameters',
      'image': 'https://images.unsplash.com/photo-1579152276236-a19614457e5b?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'T4',
      'name': 'Thyroid Profile',
      'category': 'Hormone',
      'price': 40,
      'fasting': 'Overnight',
      'reportsIn': '12h',
      'parameters': '3 Parameters',
      'image': 'https://images.unsplash.com/photo-1551601651-2a8555f1a136?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'T5',
      'name': 'HbA1c (Diabetes)',
      'category': 'Diabetes',
      'price': 28,
      'fasting': 'No Fasting',
      'reportsIn': '6h',
      'parameters': 'Average 3 months',
      'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'T6',
      'name': 'Kidney Function Test',
      'category': 'Pathology',
      'price': 32,
      'fasting': 'Fasting Required',
      'reportsIn': '10h',
      'parameters': '9 Parameters',
      'image': 'https://images.unsplash.com/photo-1579152173114-b4ad170055b7?q=80&w=200&auto=format&fit=crop',
    },
  ];

  int get _cartTotal => _cart.fold(0, (sum, id) {
        final test = _labTests.firstWhere((t) => t['id'] == id);
        return sum + (test['price'] as int);
      });

  @override
  Widget build(BuildContext context) {
    final filteredTests = _labTests.where((test) {
      return test['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          test['category'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: diagnosticViolet,
        elevation: 0,
        title: const Text('Diagnostic Lab Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorWhite),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search & Fasting banner
          Container(
            padding: const EdgeInsets.all(16),
            color: diagnosticViolet,
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search diagnostic tests (CBC, Thyroid, HbA1c)...',
                hintStyle: const TextStyle(fontSize: 13, color: textMuted),
                prefixIcon: const Icon(Icons.search, color: diagnosticViolet),
                filled: true,
                fillColor: colorWhite,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.6,
              ),
              itemCount: filteredTests.length,
              itemBuilder: (context, index) {
                final test = filteredTests[index];
                final inCart = _cart.contains(test['id']);
                return FadeSlideTransitionWidget(
                  index: index,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderGrey),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Test Image
                        Expanded(
                          flex: 5,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                            child: Image.network(
                              test['image'],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test['name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 9, color: textDark, height: 1.1),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                test['category'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 8, color: textMuted),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${test['price']}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: diagnosticViolet),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (inCart) {
                                          _cart.remove(test['id']);
                                        } else {
                                          _cart.add(test['id']);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: inCart ? wellnessGreen : diagnosticViolet,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(
                                        inCart ? Icons.check : Icons.add,
                                        size: 12,
                                        color: colorWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.timer_outlined, size: 8, color: textMuted),
                                  const SizedBox(width: 1),
                                  Text(
                                    test['reportsIn'],
                                    style: const TextStyle(fontSize: 7, color: textMuted),
                                  ),
                                  const Spacer(),
                                  Text(
                                    test['fasting'].split(' ')[0],
                                    style: const TextStyle(fontSize: 7, color: textMuted),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Checkout Bar
          if (_cart.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorWhite,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, -2))],
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${_cart.length} Tests in Cart', style: const TextStyle(fontSize: 12, color: textMuted)),
                        Text('\$$_cartTotal Total', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark)),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: diagnosticViolet,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeSampleCollectionScreen(
                              selectedTestNames: _cart.map((id) => _labTests.firstWhere((t) => t['id'] == id)['name'].toString()).toList(),
                              totalPrice: _cartTotal,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.home_outlined, color: colorWhite),
                      label: const Text('Book Home Collection', style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
