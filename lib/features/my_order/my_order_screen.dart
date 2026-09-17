import 'package:flutter/material.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> activeOrders = [
    {
      "orderNo": "#1024",
      "date": "Today, 10:30 AM",
      "status": "Preparing",
      "statusColor": const Color(0xFFFFF1D6),
      "statusTextColor": const Color(0xFFE99A00),
      "items": [
        "2x  Chicken Burger",
        "1x  French Fries",
      ],
      "total": "Rs. 1,350",
    },
    {
      "orderNo": "#1023",
      "date": "Yesterday, 7:15 PM",
      "status": "Delivered",
      "statusColor": const Color(0xFFE7F8EE),
      "statusTextColor": const Color(0xFF39A66B),
      "items": [
        "1x  Chicken Pizza",
        "1x  Coca Cola",
      ],
      "total": "Rs. 1,050",
    },
    {
      "orderNo": "#1022",
      "date": "2 May, 1:20 PM",
      "status": "Delivered",
      "statusColor": const Color(0xFFE7F8EE),
      "statusTextColor": const Color(0xFF39A66B),
      "items": [
        "1x  Beef Burger",
      ],
      "total": "Rs. 650",
    },
  ];

  final List<Map<String, dynamic>> previousOrders = [
    {
      "orderNo": "#1021",
      "date": "28 April, 8:30 PM",
      "status": "Delivered",
      "statusColor": const Color(0xFFE7F8EE),
      "statusTextColor": const Color(0xFF39A66B),
      "items": [
        "2x  Zinger Burger",
        "1x  Pepsi",
      ],
      "total": "Rs. 1,200",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;
    final orders = selectedTab == 0 ? activeOrders : previousOrders;

    return Scaffold(
      backgroundColor: colorScheme.surface,

      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        title: Text("My Orders",style: theme.textTheme.titleMedium?.copyWith(
          fontSize: 17,
           fontWeight: FontWeight.w600,
            color: colorScheme.onSurface
        )),
        // title: const Text(
        //   "My Orders",
        //   style: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.w600,
        //     color: Colors.black,
        //   ),
        // ),
      ),

      body: Column(
        children: [
          // ---------------- TABS ----------------
          Row(
            children: [
              Expanded(
                child: _buildTab(
                  title: "Active",
                  index: 0,
                ),
              ),
              Expanded(
                child: _buildTab(
                  title: "Previous",
                  index: 1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // ---------------- ORDER LIST ----------------
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(orders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= TAB =================

  Widget _buildTab({
    required String title,
    required int index,
  }) {
    final bool isSelected = selectedTab == index;
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isSelected ?FontWeight.w600 :FontWeight.w400,
              color: isSelected? colorScheme.primary : colorScheme.onSurface.withOpacity(.55)

            ),
            // style: TextStyle(
            //   fontSize: 12,
            //   fontWeight:
            //   isSelected ? FontWeight.w600 : FontWeight.w400,
            //   color: isSelected
            //       ? colorScheme.primary
            //       : Colors.black54,
            // ),
          ),
        ),
      ),
    );
  }

  // ================= ORDER CARD =================

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.surface.withOpacity(.10),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ---------- ORDER HEADER ----------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order ${order["orderNo"]}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface
                )
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: order["statusColor"],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order["status"],
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: order["statusTextColor"]
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 2),

          // ---------- DATE ----------
          Text(
            order["date"],
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 12,
              color: colorScheme.onSurface.withOpacity(.55)
            ),
          ),

          const SizedBox(height: 7),

          // ---------- ITEMS ----------
          ...List.generate(
            order["items"].length,
                (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  order["items"][index],
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    color: colorScheme.onSurface.withOpacity(0.80)
                  )
                ),
              );
            },
          ),

          const SizedBox(height: 3),

          // ---------- TOTAL + DETAILS ----------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: ${order["total"]}",
                style:theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface),
              ),

              GestureDetector(
                onTap: () {
                  // Navigate to Order Details screen
                },
                child: Text(
                  "View Details",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}