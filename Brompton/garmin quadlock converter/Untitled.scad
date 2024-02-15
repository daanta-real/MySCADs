garminOuterHeight = 3;

// 아랫면을 3mm 쉘로 파내기
difference() {
    cylinder(h = 5, d = 30, $fn = 100);
    translate([0, 0, 0]);
    cylinder(h = 5, d = 30 - 2 * 3, $fn = 100);
}

    cylinder(h = 5, d = 30, $fn = 100);