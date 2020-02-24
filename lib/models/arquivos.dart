class Processo {
  final String advogado, oab, autor, cep, cidade, comarca, contato, cpf;
  final String data, protocolo, uf, vara, status;
  final List archives;

  Processo({
    this.advogado, 
    this.oab, 
    this.autor, 
    this.cep, 
    this.cidade,
    this.comarca,
    this.contato,
    this.cpf,
    this.data,
    this.protocolo,
    this.uf,
    this.vara,
    this.archives,
    this.status
  });

  factory Processo.fromJson(Map<String, dynamic> json) {
    return Processo(
      advogado: json['advogado'],
      oab: json['oab'],
      autor: json['autor'],
      cep: json['cep'],
      cidade: json['cidade'],
      comarca: json['comarca'],
      contato: json['contato'],
      cpf: json['cpf'],
      data: json['data'],
      protocolo: json['protocolo'],
      uf: json['uf'],
      vara: json['vara'],
      archives: json['archives'],
      status: json['status']
    );
  }
}