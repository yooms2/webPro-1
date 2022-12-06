package com.lec.ex1_student;

import java.io.ObjectInputStream.GetField;

public class StudentMain {
	public static void main(String[] args) {
		Student s1 = new Student("���켺", 90, 90, 90);
		Student s2 = new Student("���ϴ�", 90, 90, 91);
		Student s3 = new Student("Ȳ����", 80, 80, 90);
		Student s4 = new Student("������", 80, 90, 90);
		Student s5 = new Student("������", 70, 70, 90);
		Student[] students = {s1, s2, s3, s4, s5};
		String[] title = {"�̸�","����","����","����","����","���"};
//		int korTot=0;
//		int engTot = 0;
//		int matTot = 0;
//		int totTot = 0;
//		int avgTot = 0;
		int[] total = new int[5];// 0��idx:�����, 1��idx:�����..4��idx:��մ���
		line(); 
		System.out.println("\t\t����ǥ");
		line('-');
		for(String t : title) {
			System.out.print("\t" + t);
		}
		System.out.println(); // ����
		line('-');
		for(Student student : students) {
			System.out.print(student.infoString());
			//student.infoPrint();
			// ��������(��,��,��,��,��) ����
			total[0] += student.getKor(); // ���� ����
			total[1] += student.getEng(); // ���� ����
			total[2] += student.getMat(); // ���� ����
			total[3] += student.getTot(); // ���� ����
//			total[4] = total[4] + student.getAvg(); // ��� ���� ����
			total[4] += student.getAvg(); // ��� ����
		}
		line('-');
		System.out.print("\t����");
		for(int t : total) {
			System.out.print("\t"+t);
		}
		System.out.print("\n\t���");
		for(int t : total) {
			//System.out.print("\t" + t/students.length);
			System.out.printf("\t%.1f", (double)t/students.length);
		}
		System.out.println();//����
		line();
	}

	private static void line(char c) {
		System.out.print("\t");
		for(int i=0 ; i<=50 ; i++) {
			System.out.print("-");
		}
		System.out.println();
	}

	private static void line() {
		for(int i=0 ; i<65 ; i++) {
			System.out.print("��");
		}
		System.out.println();
	}
}