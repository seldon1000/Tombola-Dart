/*Classe per generare le cartelle e una lista di numeri casuali da 1 a 90 (chiaramenti senza duplicati).
  Si occupa anche di tenere traccia dei possibili punteggi e dei numeri estratti.*/

import 'dart:math';
import 'dart:io';

class Cartella{
  var _board; //cartella effettiva formata da 25 numeri (5x5)
  static int _indexPunteggio, //punterà al prossimo punteggio disponibile
             _indexNumero; //punterà all'ultimo numero estratto
  static List<int> _punteggi, //conterrà 4 zeri inizialmente, che diventeranno 1 man mano che un giocatore fa un punteggio
                   _listaCasuali; //lista di 90 numeri generata casualmente, il numero sarà estratto da qui

  Cartella(){
    _board = new List<int>();
    _indexPunteggio = 0;
    _indexNumero = 0;
    _punteggi = new List<int>.generate(4, (_) => 0); //genero 4 numeri uguali a 0 nella lista
    _listaCasuali = new List<int>.generate(90, (_) => _ + 1); //genero 90 numeri nella lista
    _listaCasuali.shuffle(); //riorganizzo casualmente i numeri nella lista

    int min = 1, max = 4, temp; /*l'idea è quella che ogni colonna può contenere valori compresi in un intervallo di 20 numeri, 
                                  mentre ogni casella può contenere un valore in un intervallo di 4 numeri, dopodichè si passa all'intervallo successivo*/
    Random numero = new Random();

    while(max <= 90){
      temp = min + numero.nextInt(max - min);
      _board.add(temp);

      if(max >= 80){
        min = max;  /*quando mi trovo nell'ultima colonna, l'intervallo restante contiene solo 10 numeri invece di 20,
                      quindi ogni casella otterrà un valore in un intervallo di 2 numeri anzichè 4*/
        max += 2;
      }
      else{
        min = max + 1;
        max += 4;
      }
    }

    print('Cartella creata!');
  }
  
  int spuntaCasella(int x){
    int k;
    _indexNumero = x;
    x = _listaCasuali[_indexNumero];

    if(x < 20) k = 5; //verifico in quale intervallo si trova il numero, in modo da dover scorrere al più 5 numeri piuttosto che tutta la cartella (25)
    else if(x < 40) k = 10;
    else if(x < 60) k = 15;
    else if(x < 80) k = 20;
    else k = 25;

    for(int i = k - 5; i < k; i++){
      if(_board[i] == x){
        _board[i] = 0;

        if(_indexNumero > 1) return checkPunteggio(); /*se trovo una corrispondenza, la casella diventa uguale a 0 e, se è stato estratto più di un numero,
                                                        effettuo un controllo per sapere se la cartella può ottenere un punteggio. Se la cartella ha ottenuto un punteggio,
                                                        ritorno il numero di quel punteggio (0 = ambo; 1 = terna; 2 = quaterna; 3 = quintina). Se la cartello non ottiene
                                                        alcun punteggio, ritorno -1 e proseguo l'estrazione. Se la cartella ha fatto tombola, ritorno -10*/
        return -1;
      }
    }
  }

  int checkPunteggio(){
    int i = 0, j, count, countTombola = 0;  /*count conterà gli 0 a livello di riga per i punteggi bassi, mentre countTombola conterà gli 0 in tutta la cartella per
                                              controllare se il giocatore ha fatto tombola (controllerà solo se sono usciti almeno 25 numeri e se i punteggi più
                                              bassi sono già stati tutti assegnati.*/

    while(i < 5){
      j = 0;
      count = 0;

      while(i + 5 * j < 25){
        if(_board[i + 5 * j] == 0){
          count++;
          countTombola++;
        }
        else if(_indexPunteggio == 4 && _indexNumero >= 25) break;

        j++;
      }

      if(count == _indexPunteggio + 2 && _indexPunteggio < 4){
        _punteggi[_indexPunteggio] = 1;

        return _indexPunteggio++;
      }

      i++;
    }

    if(countTombola == 25) return -10;
    return -1;
  }

  void printCartella(int x){
    print("Cartella $x: ");

    for(int i = 0; i < 5; i++){
      for(int j = 0; i + 5 * j < 25; j++) stdout.write("${_board[i + 5 * j]} ");  //stampo sulla stessa riga
      print("\n");
    }
  }

  static int numero(int x) => _listaCasuali[x];  //utile per ricavare il numero estratto
}