#include "sbor.hpp"

extern  Contr  CNT;
extern  ofstream   Fout;
extern  int NFR;

  Kadr::  Kadr( )
   {
     char SIM[60];

   if( ! ( DATE =  new  int[CNT.NCA+CNT.NCF+1]) )
    {   cout<<"\n Не  выделена  память ! ";  exit(1);  }

    if( ! ( TORA =  new double[CNT.NCA*3]) )
    {   cout<<"\n Не  выделена  память ! ";  exit(1);  }

    if( ! ( TORF =  new float[CNT.NCF]) )
    {   cout<<"\n Не  выделена  память ! ";  exit(1);  }


     ifstream  Tin(CNT.FileTOR );
   if( ! Tin )
      {  cout<<"\n Не найден файл с тоpиpовками"<<CNT.FileTOR ;
	    exit(1);  }

      Tin >> CNT.FREQ;
      Tin >> SIM;
      Tin >> CNT.NFREQ;
      Tin >> SIM;

     div_t FR= div(CNT.FREQ,16);
      NFR = FR.quot*4;
     if( NFR<16 )  NFR=16;

    for( int i=0; i<CNT.NCA*3; i++ )
      Tin >>  TORA[i];

    for( i=0; i<CNT.NCF; i++ )
      Tin >>  TORF[i];
	Tin.close();

    for( i=0; i<CNT.NCA+CNT.NCF+1; i++ )
	DATE[i]=0;

  }


   Kadr::  ~Kadr()
    {
      delete  DATE;
      delete  TORA;
      delete  TORF;
     }


 void  Kadr::  WRITE( )
   {
     Fout.write((char *) DATE,(CNT.NCA+CNT.NCF+1)*2);
     if( Fout. rdstate())
     { cout<<"\n Ошибка записи в файл "; Fout.close(); exit(1); }
    }


  void  Kadr::  VISION()
    {
 //     static i=0;
      unsigned  LOG=1;

 /*    if( i>15 )
      {   i++; i=i%NFR;  gotoxy(1,1);  return;  }
   */
    for( int i=0; i<16; i++ )
      {
       gotoxy(15,7+i);
       cprintf("%6d",DATE[i]);
       gotoxy(1,1);
  /*
       gotoxy(40,7+i);
      if( LOG & DATE[CNT.NCA+CNT.NCF] )
	cputs("1");
       else  cputs("0");
       LOG=LOG<<1;
    */
       if( ! (i%2) )
	   {
	     gotoxy(60,7+i);
	     cprintf("%6u",(unsigned) DATE[CNT.NCA+i/2]);
	  }
       }
       gotoxy(1,1);

 /*    i++;
      i=i%NFR;
   */

      }


  void  Kadr:: WRITE_TOR()
     {
      ofstream  Tout( CNT.FileTOR );
       Tout.setf( ios::fixed, ios::floatfield );
       Tout. precision(12);
       Tout<<"\n\t"<<CNT.FREQ;
       Tout<<"\t частота_опpоса_АЦП";
       Tout<<"\n\t"<<CNT.NFREQ;
       Tout<<"\t отношение_для_частотных_каналов";

     for( int i=0; i<CNT.NCA*3; i++ )
       {
	 if( ! (i%3) )  Tout<<'\n';
	 Tout << '\t' << TORA[i];
	}

    for( i=0; i<CNT.NCF; i++ )
      Tout << "\n\t" << TORF[i];

      Tout.close();
	 }


 int  Kadr:: GET_CAN( int  NUM )
       {
	 return  DATE[NUM];
	}


   void  Kadr:: APROKS( double * x, double * y, int n, int num)
	 /*  вычисление  коэффициентов  полинома
             x - массив значений токов
             y - массив вычесленных значений
	     n - количество замеров
	     num - номер канала   */
 {
    char YN; // Ответ на запрос
    double A,B; // Попроавочный коэффициент
    int i,j,k,m1,k1; // Счетчики
    int m=2; // (Количество коэффициентов) - 1 ?
    double r,s; // Накполение чего-то там
    double a[10][11];
    double c[11]; // Тарировка
    double q[200]; // Задан явно с запасом. Размер - количество замеров n

    // Задать массив и забить его нулями. Размерность - количество коэффициентов
    // с = 10 * 1 Здесь и далее максимальная размерность массива для данного цикла
    for(i=0;i<=10;i++)   c[i]=0;
    n--;  // n:=n-1 Смещение индекса

    // Задать массив и забить его единицами. Размерность - количество коэффициентов
    // i = 0..n
    for(i=0;i<=n;i++)    q[i]=1;
    // Расчет
    // i = 0..2
    for(i=0;i<=m;i++)
      // По количеству коэффициентов
      {
	s=0;   r=0;
	// j = 0..n
	for(j=0;j<=n;j++)
        // Количество замеров + 1
	  {
            // Сумма единиц o_0
	    s=s+q[j];
            // 0+1*значение o_0
	    r=r+q[j]*y[j];
            // Можно тупо взять массив из параметров
	    q[j]=q[j]*x[j];
	  }
        // Номер?
	a[0][i]=s;
        // Запись значения
	a[i][m+1]=r;
      }
// конец цикла

    // i = 1..2
    for(i=1;i<=m;i++)
      {
	s=0;
	// j = 0..n
	for(j=0;j<=n;j++)
	  {
           // Проверка на диаганаль ?
	   // a = 2 * n
	   if(j<m)   a[i][j]=a[i-1][j+1];
	   s=s+q[j];
	   q[j]=q[j]*x[j];
	  }
	a[i][m]=s;
      }
// конец цикла

     // m1 = 3
     m1=m+1;
     // k = 0..2
     for(k=0;k<=m;k++)
       {
         // смещение для правильно задания индекса?
	 // k1 = 1..3
	 k1=k+1;
	 // a = 2 * 2
	 s=a[k][k];
	 // j = 1..3
	 // a = 2 * 3
	 for(j=k1;j<=m1;j++)       a[k][j]=a[k][j]/s;

	 // i = 1..2
	 for(i=k1;i<=m;i++)
	   {
	     // a = 2 * 2
	     r=a[i][k];
	     // j = 1..3
	     // a = 2 * 3
	     for(j=k1;j<=m1;j++)   a[i][j]=a[i][j]-a[k][j]*r;
	   }
	// конец цикла
	}
// конец цикла
	// m = 2, i = 2..0
	for(i=m;i>=0;i--)
	   {
	     s=a[i][m1];
	      // m = 2, j = 1..2
	      for(j=i+1;j<=m;j++)
	       {
		 s=s-a[i][j]*c[j]; // WTF? Массив c еще не инициализирован!
		}
	      c[i]=s;
	    }

       // Запись результатов
       TORA[num*3]=c[0];
       TORA[num*3+1]=c[1];
       TORA[num*3+2]=c[2];
    // Ввод поправочных коэффициентов
    cout<<"\n\n Надо вводить попpавочные коэффициент  a*x ? ( Y/N ) : ";
    cin>>YN;
    if( YN == 'Y' || YN == 'y' )
     {
       cout<<"\n введите коэффициент пpи линейном члене :  ";
       cin>>A;
       // Домножение
       TORA[num*3] *= A;
       TORA[num*3+1] *= A;
       TORA[num*3+2] *= A;
     }
  }

