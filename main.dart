import 'dart:io';
import 'cartella.dart';

void gioco(int k){
  List<Cartella> cartelle = new List<Cartella>();

  for(int j = 0; j < k; j++) cartelle.add(new Cartella());

  for(int i = 0; i < 90; i++){
    print("Numero: ${Cartella.numero(i)}");

    for(int j = 0; j < k; j++){
      switch(cartelle[j].spuntaCasella(i)){
        case 0: {
          print("\nIl giocatore $j ha fatto ambo!\n");
          cartelle[j].printCartella(j);
        } break;

        case 1: {
          print("\nIl giocatore $j ha fatto terna!\n");
          cartelle[j].printCartella(j);
        } break;

        case 2: {
          print("\nIl giocatore $j ha fatto quaterna!\n");
          cartelle[j].printCartella(j);
        } break;

        case 3: {
          print("\nIl giocatore $j ha fatto quintina!\n");
          cartelle[j].printCartella(j);
        } break;

        case -10:{
          print("\nIl giocatore $j ha fatto TOMBOLA! Fine del gioco.\n");
          return;
        } break;
      }
    }
  }
}

void main(){
  int scelta;
  print("Ciao, benvenuto nel gioco della tombola.\nOgni giocatore ha a disposizione una sola cartella.");

  do{
    print("Quanti giocatori ci sono? ");
    scelta = int.parse(stdin.readLineSync());

    gioco(scelta);

    print("\nIl gioco e' terminato. Vuoi avviare una nuova partita? [Si-1 No-0] ");
    scelta = int.parse(stdin.readLineSync());
  } while(scelta != 0);
}