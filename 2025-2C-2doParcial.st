!classDefinition: #Baje category: #'2025-2C-2doParcial'!
Object subclass: #Baje
	instanceVariableNames: 'saldo descuento historialDeViajes'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!Baje methodsFor: 'accediendo' stamp: 'VS 11/25/2025 21:49:06'!
assertPuedeCargar: unaCantidadDeSaldo

	self assertCantidadValidaDeSaldo: unaCantidadDeSaldo.
! !

!Baje methodsFor: 'accediendo' stamp: 'VS 11/25/2025 17:22:09'!
saldoIgualA: unaCantidadDeSaldo 
	
	^saldo = unaCantidadDeSaldo ! !

!Baje methodsFor: 'accediendo' stamp: 'VS 11/25/2025 19:24:50'!
sinSaldo
	"se asumio que no existen los saldos negativos como en la vida real"
	^saldo = (0*peso)! !


!Baje methodsFor: 'inicializacion' stamp: 'VS 11/25/2025 21:10:21'!
initialize

saldo := 0*peso.

descuento := 1.

historialDeViajes := OrderedCollection new.! !


!Baje methodsFor: 'historial' stamp: 'VS 11/25/2025 21:13:53'!
agregarViajeAlHistorial: costoDelBoleto en: unMedioDeTransporte distancia: unOrigen enFecha: unaFecha

| datos |
datos := OrderedCollection new.
datos add: costoDelBoleto ; add: unMedioDeTransporte ; add: unOrigen.

historialDeViajes add: datos.! !

!Baje methodsFor: 'historial' stamp: 'VS 11/25/2025 21:16:45'!
ultimaDistancia
	
	^historialDeViajes last at: 3! !

!Baje methodsFor: 'historial' stamp: 'VS 11/25/2025 21:21:32'!
ultimaTarifaPagada
	
	^historialDeViajes last first! !

!Baje methodsFor: 'historial' stamp: 'VS 11/25/2025 21:11:33'!
ultimoTransporteTomado
	
^historialDeViajes last at: 2! !


!Baje methodsFor: 'viajando' stamp: 'VS 11/25/2025 21:13:53'!
intentarCobrarBoletoDe: costoDelBoleto enFecha: unaFecha enTransporte: unMedioDeTransporte porDistancia: unaDistancia    

|costoDelBoletoConDescuento |.
costoDelBoletoConDescuento := self calcularBoletoConDescuento: costoDelBoleto enFecha: unaFecha .
self assertSaldoSuficiente: costoDelBoletoConDescuento .

self agregarViajeAlHistorial: costoDelBoleto en: unMedioDeTransporte distancia: unaDistancia enFecha: unaFecha.
saldo := saldo - costoDelBoletoConDescuento ! !


!Baje methodsFor: 'saldo' stamp: 'VS 11/25/2025 21:46:52'!
cargar: unaCantidadDeSaldo 

self assertPuedeCargar: unaCantidadDeSaldo.
saldo := saldo + unaCantidadDeSaldo 
	! !


!Baje methodsFor: 'descuentos' stamp: 'VS 11/25/2025 21:21:04'!
calcularBeneficioYAplicarlo
	
	|ultimoTransporte reintegro tarifaAPagar |.
	
	ultimoTransporte := self ultimoTransporteTomado .
	
	tarifaAPagar := ultimoTransporte tarifaPorDistancia: self ultimaDistancia.
	reintegro := self ultimaTarifaPagada - tarifaAPagar.
	self recibirReintegro: reintegro! !

!Baje methodsFor: 'descuentos' stamp: 'VS 11/25/2025 19:04:57'!
calcularBoletoConDescuento: unBoleto enFecha: unaFecha

^unBoleto ! !

!Baje methodsFor: 'descuentos' stamp: 'VS 11/25/2025 21:07:38'!
recibirDescuentosPorMarcarSalida

|ultimoTransporteTomado|.
ultimoTransporteTomado := self ultimoTransporteTomado.
ultimoTransporteTomado tieneBeneficiosPorMarcarSalida ifTrue: [
	
	self calcularBeneficioYAplicarlo
	]! !

!Baje methodsFor: 'descuentos' stamp: 'VS 11/25/2025 21:22:00'!
recibirReintegro: reintegro 
	
	self cargar: reintegro! !


!Baje methodsFor: 'asserts' stamp: 'VS 11/25/2025 21:44:44'!
assertCantidadValidaDeSaldo: unaCantidadDeSaldo

	^ (unaCantidadDeSaldo <= 0) ifTrue: [self error: self class elSaldoACargarDebeSerPositivoDescripcionDeError]! !

!Baje methodsFor: 'asserts' stamp: 'VS 11/25/2025 21:46:39'!
assertSaldoEsNumeroEntero: unaCantidadDeSaldo

	^ (unaCantidadDeSaldo isInteger ) ifFalse: [self error: self class elSaldoACargarDebeSerEnteroDescripcionDeError]! !

!Baje methodsFor: 'asserts' stamp: 'VS 11/25/2025 19:26:00'!
assertSaldoSuficiente: costoDelBoleto

	^ (self saldoAlcanzaACubrir: costoDelBoleto) ifTrue: [self error: self class saldoInsuficienteDescripcionDeError]! !

!Baje methodsFor: 'asserts' stamp: 'VS 11/25/2025 19:25:55'!
saldoAlcanzaACubrir: costoDelBoleto

	^ (saldo - costoDelBoleto) < (0*peso)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Baje class' category: #'2025-2C-2doParcial'!
Baje class
	instanceVariableNames: ''!

!Baje class methodsFor: 'descripciones de error' stamp: 'VS 11/25/2025 21:45:36'!
elSaldoACargarDebeSerEnteroDescripcionDeError
	
	^'el saldo a cargar debe ser entero!!'! !

!Baje class methodsFor: 'descripciones de error' stamp: 'VS 11/25/2025 21:43:51'!
elSaldoACargarDebeSerPositivoDescripcionDeError
	
	^'no se puede cargar saldo negativo!!'! !

!Baje class methodsFor: 'descripciones de error' stamp: 'VS 11/25/2025 18:11:59'!
saldoInsuficienteDescripcionDeError
	
	^'el saldo no cubre el costo del boleto :('! !


!classDefinition: #BajeConDescuentoDeJubilado category: #'2025-2C-2doParcial'!
Baje subclass: #BajeConDescuentoDeJubilado
	instanceVariableNames: 'boletosGratis'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!BajeConDescuentoDeJubilado methodsFor: 'inicializacion' stamp: 'VS 11/25/2025 19:17:42'!
initialize
	
	super initialize.
	
	boletosGratis := 2.! !


!BajeConDescuentoDeJubilado methodsFor: 'descuentos' stamp: 'VS 11/25/2025 19:19:07'!
calcularBoletoConDescuento: costoDelBoleto enFecha: unaFecha 
	
	(boletosGratis > 0) ifTrue: [boletosGratis := boletosGratis -1. ^0].
	
	^costoDelBoleto ! !


!classDefinition: #BajeConDescuentoEstudiantil category: #'2025-2C-2doParcial'!
Baje subclass: #BajeConDescuentoEstudiantil
	instanceVariableNames: 'fechasDondeAplicaElDescuento'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!BajeConDescuentoEstudiantil methodsFor: 'inicializacion' stamp: 'VS 11/25/2025 18:57:13'!
initialize

super initialize .

descuento := 1/ 2.

fechasDondeAplicaElDescuento := TimeLineFilter named: 'Dias de Semana'.
	
fechasDondeAplicaElDescuento addDayRule: GregorianDay saturday;
		addDayRule: GregorianDay sunday.
	fechasDondeAplicaElDescuento := fechasDondeAplicaElDescuento negated.! !


!BajeConDescuentoEstudiantil methodsFor: 'descuentos' stamp: 'VS 11/25/2025 19:01:17'!
aplicarDescuentoA: unBoleto 

^unBoleto * descuento! !

!BajeConDescuentoEstudiantil methodsFor: 'descuentos' stamp: 'VS 11/25/2025 19:26:44'!
calcularBoletoConDescuento: unBoleto enFecha: unaFecha

(self elDescuentoEsAplicableEn: unaFecha ) ifTrue: [^self aplicarDescuentoA: unBoleto ].

^unBoleto 


! !

!BajeConDescuentoEstudiantil methodsFor: 'descuentos' stamp: 'VS 11/25/2025 19:26:44'!
elDescuentoEsAplicableEn: unaFecha

	^ fechasDondeAplicaElDescuento includes: unaFecha date! !


!classDefinition: #LectorDeTarjeta category: #'2025-2C-2doParcial'!
Object subclass: #LectorDeTarjeta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!LectorDeTarjeta methodsFor: 'cobrando' stamp: 'VS 11/25/2025 21:23:34'!
cobrarCon: unaTarjetaBaje conOrigen: unaParadaDeOrigen yDestino: unaParadaDestino enMedioDeTransporte: unMedioDeTransporte enDia: unaFecha  

| costoDelBoleto |
self assertViajeEsValidoDesde: unaParadaDeOrigen hacia: unaParadaDestino en: unMedioDeTransporte .

costoDelBoleto := self calcularCostoDelBoletoDesde: unaParadaDeOrigen hasta:  unaParadaDestino en:  unMedioDeTransporte .

unaTarjetaBaje intentarCobrarBoletoDe: costoDelBoleto enFecha: unaFecha enTransporte: unMedioDeTransporte porDistancia: (self calcularDistanciaDesde: unaParadaDeOrigen hasta: unaParadaDestino) .
! !


!LectorDeTarjeta methodsFor: 'asserciones' stamp: 'VS 11/25/2025 20:14:07'!
assertElTransporte: unMedioDeTransporte tieneParadaEn: unaParada

	^ (unMedioDeTransporte paraEn: unaParada) ifFalse: [self error: self class paradaNoPerteneceALaLineaSolicitada]! !

!LectorDeTarjeta methodsFor: 'asserciones' stamp: 'VS 11/25/2025 19:41:46'!
assertOrigen: unaParadaDeOrigen distintoA: unaParadaDestino

	^ (unaParadaDeOrigen isEqualTo: unaParadaDestino ) ifTrue: [self error: self class viajeInvalidoDescripcionDeError ]! !

!LectorDeTarjeta methodsFor: 'asserciones' stamp: 'VS 11/25/2025 21:23:51'!
assertViajeEsValidoDesde: unaParadaDeOrigen hacia: unaParadaDestino en: unMedioDeTransporte

self assertOrigen: unaParadaDeOrigen distintoA: unaParadaDestino.
self assertElTransporte: unMedioDeTransporte tieneParadaEn: unaParadaDestino.
self assertElTransporte: unMedioDeTransporte tieneParadaEn: unaParadaDeOrigen! !


!LectorDeTarjeta methodsFor: 'calculando costo del boleto' stamp: 'VS 11/25/2025 21:18:18'!
calcularCostoDelBoletoDesde: unaParadaDeOrigen hasta: unaParadaDestino en: unMedioDeTransporte


| kilometrosDeRecorrido |
kilometrosDeRecorrido := self calcularDistanciaDesde: unaParadaDeOrigen hasta: unaParadaDestino .

^ unMedioDeTransporte tarifaPor: kilometrosDeRecorrido.! !

!LectorDeTarjeta methodsFor: 'calculando costo del boleto' stamp: 'VS 11/25/2025 21:18:18'!
calcularDistanciaDesde: unaParadaDeOrigen hasta: unaParadaDestino

	^ unaParadaDeOrigen distanciaHasta: unaParadaDestino! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LectorDeTarjeta class' category: #'2025-2C-2doParcial'!
LectorDeTarjeta class
	instanceVariableNames: ''!

!LectorDeTarjeta class methodsFor: 'error description' stamp: 'VS 11/25/2025 20:10:00'!
paradaNoPerteneceALaLineaSolicitada
	
	^'el medio de transporte elegido no va hasta ahi!!'! !

!LectorDeTarjeta class methodsFor: 'error description' stamp: 'VS 11/25/2025 20:10:07'!
viajeInvalidoDescripcionDeError
	
	
	^'el viaje debe tener distinto origen y destino!!'! !


!classDefinition: #LectorDeTarjetaParaMarcarSalida category: #'2025-2C-2doParcial'!
LectorDeTarjeta subclass: #LectorDeTarjetaParaMarcarSalida
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!LectorDeTarjetaParaMarcarSalida methodsFor: 'marcar salida' stamp: 'VS 11/25/2025 21:04:55'!
marcarSalidaDe: unaTarjetaBaje

unaTarjetaBaje recibirDescuentosPorMarcarSalida! !


!classDefinition: #MedioDeTransporte category: #'2025-2C-2doParcial'!
Object subclass: #MedioDeTransporte
	instanceVariableNames: 'paradas tarifario'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!MedioDeTransporte methodsFor: 'inicializacion' stamp: 'VS 11/25/2025 21:37:24'!
initializeConParadas: unaColeccionDeParadas conTarifario: unTarifario  

	paradas := unaColeccionDeParadas.
	tarifario := unTarifario 
	! !


!MedioDeTransporte methodsFor: 'tarifas' stamp: 'VS 11/25/2025 20:42:59'!
tarifaPor: unosKilometrosDeRecorrido

	self subclassResponsibility! !


!MedioDeTransporte methodsFor: 'accediendo' stamp: 'VS 11/25/2025 18:36:08'!
paraEn: unaParadaDestino 
	
	^paradas anySatisfy: [:unaParada | unaParada isEqualTo: unaParadaDestino ]! !


!MedioDeTransporte methodsFor: 'beneficios' stamp: 'VS 11/25/2025 21:12:16'!
tieneBeneficiosPorMarcarSalida

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MedioDeTransporte class' category: #'2025-2C-2doParcial'!
MedioDeTransporte class
	instanceVariableNames: ''!

!MedioDeTransporte class methodsFor: 'error description' stamp: 'VS 11/25/2025 17:38:18'!
elRecorridoDebeTenerAlMenosDosParadasDescripcionDeError
	
	^'el recorrido debe tener por lo menos dos paradas'! !


!MedioDeTransporte class methodsFor: 'instance creation' stamp: 'VS 11/25/2025 21:37:19'!
conParadas: unaColeccionDeParadas yTarifario: unTarifario
	
	self assertTieneMinimaCantidadDeParadas: unaColeccionDeParadas.
	
	
	^self new initializeConParadas: unaColeccionDeParadas conTarifario: unTarifario ! !


!MedioDeTransporte class methodsFor: 'asserciones' stamp: 'VS 11/25/2025 17:39:31'!
assertTieneMinimaCantidadDeParadas: unaColeccionDeParadas

	^ (unaColeccionDeParadas size < 2) ifTrue: [self error: self elRecorridoDebeTenerAlMenosDosParadasDescripcionDeError ]! !


!classDefinition: #Colectivo category: #'2025-2C-2doParcial'!
MedioDeTransporte subclass: #Colectivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!Colectivo methodsFor: 'tarifas' stamp: 'VS 11/25/2025 21:38:38'!
tarifaPor: unosKilometrosDeRecorrido

unosKilometrosDeRecorrido <= (5*kilometer) ifTrue: [^600*peso].
unosKilometrosDeRecorrido <= (10*kilometer) ifTrue: [^1000*peso].

^1300*peso
	
	! !


!Colectivo methodsFor: 'beneficios' stamp: 'VS 11/25/2025 21:12:36'!
tieneBeneficiosPorMarcarSalida
	
	^true! !


!classDefinition: #Subte category: #'2025-2C-2doParcial'!
MedioDeTransporte subclass: #Subte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!Subte methodsFor: 'beneficios' stamp: 'VS 11/25/2025 21:12:30'!
tieneBeneficiosPorMarcarSalida
	
	^false! !


!Subte methodsFor: 'tarifas' stamp: 'VS 11/25/2025 20:32:32'!
tarifaPor: kilometrosDeRecorrido 
	
	^1000*peso! !


!classDefinition: #Tren category: #'2025-2C-2doParcial'!
MedioDeTransporte subclass: #Tren
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!Tren methodsFor: 'tarifas' stamp: 'VS 11/25/2025 20:44:02'!
reintegroPorDistancia: unaDistancia enBaje: unaTarjetaBaje

! !

!Tren methodsFor: 'tarifas' stamp: 'VS 11/25/2025 20:43:37'!
tarifaPor: kilometrosDeRecorrido 
	
	
	^600*peso
	! !

!Tren methodsFor: 'tarifas' stamp: 'VS 11/25/2025 21:19:49'!
tarifaPorDistancia: unaDistanciaEnKilometros

(unaDistanciaEnKilometros < (15*kilometer)) ifTrue: [^400*peso].

^600*peso
	! !


!Tren methodsFor: 'beneficios' stamp: 'VS 11/25/2025 21:12:00'!
tieneBeneficiosPorMarcarSalida
	
	^true! !


!classDefinition: #Parada category: #'2025-2C-2doParcial'!
Object subclass: #Parada
	instanceVariableNames: 'nombre distanciaDesdeLaCabecera'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!Parada methodsFor: 'inicializacion' stamp: 'VS 11/25/2025 17:37:51'!
initializeConNombre: unNombre distanciaDeLaCabecera: unaDistancia 
	
	nombre := unNombre.
	distanciaDesdeLaCabecera := unaDistancia.! !


!Parada methodsFor: 'accediendo' stamp: 'VS 11/25/2025 17:46:45'!
distanciaACabeceraIgual: unaDistanciaDesdeLaCabecera

^unaDistanciaDesdeLaCabecera = distanciaDesdeLaCabecera ! !

!Parada methodsFor: 'accediendo' stamp: 'VS 11/25/2025 17:57:39'!
distanciaACabeceraMenos: unaDistancia

^distanciaDesdeLaCabecera - unaDistancia 
	! !

!Parada methodsFor: 'accediendo' stamp: 'VS 11/25/2025 17:57:19'!
distanciaHasta: unaParadaDestino 
	
	^(unaParadaDestino distanciaACabeceraMenos: distanciaDesdeLaCabecera) abs! !

!Parada methodsFor: 'accediendo' stamp: 'VS 11/25/2025 21:32:42'!
isEqualTo: otraParada

"tuve que redefinirlo porque tenia varias instancias de parada"

^(otraParada nombreIgual: nombre) and: (otraParada distanciaACabeceraIgual: distanciaDesdeLaCabecera )! !

!Parada methodsFor: 'accediendo' stamp: 'VS 11/25/2025 17:46:15'!
nombreIgual: unNombreDeParada

^unNombreDeParada = nombre! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Parada class' category: #'2025-2C-2doParcial'!
Parada class
	instanceVariableNames: ''!

!Parada class methodsFor: 'instance creation' stamp: 'VS 11/25/2025 17:37:31'!
conNombre: unNombre distanciaDeLaCabecera: unaDistancia 
	
	^self new initializeConNombre: unNombre distanciaDeLaCabecera: unaDistancia ! !


!classDefinition: #ISWMetropolitanoTest category: #'2025-2C-2doParcial'!
TestCase subclass: #ISWMetropolitanoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!ISWMetropolitanoTest methodsFor: 'lectores de tarjeta' stamp: 'VS 11/25/2025 21:03:54'!
lectorDeTarjetaDeEntradaYSalida
	
	^LectorDeTarjetaParaMarcarSalida new.! !

!ISWMetropolitanoTest methodsFor: 'lectores de tarjeta' stamp: 'VS 11/25/2025 20:58:51'!
lectorDeTarjetaEstandar

^LectorDeTarjeta new! !


!ISWMetropolitanoTest methodsFor: 'tarjetas' stamp: 'VS 11/25/2025 17:40:39'!
tarjetaBajeCon0Pesos

|tarjeta|.

tarjeta := Baje new.

^tarjeta! !

!ISWMetropolitanoTest methodsFor: 'tarjetas' stamp: 'VS 11/25/2025 17:40:30'!
tarjetaBajeCon1000Pesos

|tarjeta|.

tarjeta := Baje new.

tarjeta cargar: 1000*peso.

^tarjeta! !

!ISWMetropolitanoTest methodsFor: 'tarjetas' stamp: 'VS 11/25/2025 19:14:35'!
tarjetaBajeCon1000PesosConDescuentoDeJubilado

|tarjeta|.

tarjeta := BajeConDescuentoDeJubilado new.

tarjeta cargar: 1000*peso.

^tarjeta! !

!ISWMetropolitanoTest methodsFor: 'tarjetas' stamp: 'VS 11/25/2025 21:41:12'!
tarjetaBajeCon1000PesosConDescuentoEstudiantil
	
	|tarjeta|.
	
	tarjeta := self tarjetaBajeEstudiantilSinSaldo .
	
	tarjeta cargar: 1000*peso.
	
	
	^tarjeta! !

!ISWMetropolitanoTest methodsFor: 'tarjetas' stamp: 'VS 11/25/2025 18:20:13'!
tarjetaBajeCon2000Pesos

|tarjeta|.

tarjeta := Baje new.

tarjeta cargar: 2000*peso.

^tarjeta! !

!ISWMetropolitanoTest methodsFor: 'tarjetas' stamp: 'VS 11/25/2025 21:41:12'!
tarjetaBajeEstudiantilSinSaldo

^BajeConDescuentoEstudiantil new! !


!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 17:21:36'!
test01UnaTarjetaBajeRecienAdquiridaTieneSaldoCero

|tarjeta|.

tarjeta := Baje new.

self assert: (tarjeta saldoIgualA: 0*peso)! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 17:24:17'!
test02UnaTarjetaBajePuedeRecargarseDeSaldo

|tarjeta|.
"se asume que la tarjeta no se debe acreditar, al cargarle saldo ya lo tiene en saldo disponible"
tarjeta := Baje new.

tarjeta cargar: 500*peso.

self assert: (tarjeta saldoIgualA: 500*peso)! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 17:25:31'!
test03UnaTarjetaBajeAcumulaLasRecargasDeSaldo

|tarjeta|.

tarjeta := Baje new.

tarjeta cargar: 500*peso.
tarjeta cargar: 100*peso.
self assert: (tarjeta saldoIgualA: 600*peso)! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:36:46'!
test04UnColectivoDebeTenerAlMenosDosParadas

|paradas |.

paradas := OrderedCollection new.
paradas add: self cabeceraDel60 .
self
should: [Colectivo conParadas: paradas yTarifario: self ]
raise: Error-MessageNotUnderstood
withMessageText: MedioDeTransporte elRecorridoDebeTenerAlMenosDosParadasDescripcionDeError! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:29:26'!
test05UnaTarjetaBajeNoPuedeTenerDeOrigenLaParadaDestino

|baje parada|.

baje := self tarjetaBajeCon1000Pesos .
parada := self cabeceraDel60.
self
should: [self lectorDeTarjetaEstandar cobrarCon: baje conOrigen: parada yDestino: parada enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana ]
raise: Error-MessageNotUnderstood
withMessageText: LectorDeTarjeta viajeInvalidoDescripcionDeError! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:29:59'!
test06ElSaldoDeUnaTarjetaBajeDisminuye600PesosAlViajar5KmEnEl60

|baje origen destino|.

baje := self tarjetaBajeCon1000Pesos .
origen := self cabeceraDel60.
destino := self paradaPlazaDeMayo.
self lectorDeTarjetaEstandar cobrarCon: baje conOrigen: self cabeceraDel60 yDestino: destino enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana .

self assert: (baje saldoIgualA: 400*peso)
! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:30:37'!
test07ElSaldoDeUnaTarjetaBajeDisminuye1000PesosAlViajarMasDe5KmEnEl60

|baje origen destino|.

baje := self tarjetaBajeCon1000Pesos .
origen := self cabeceraDel60 .
destino := self paradaRetiro .
self lectorDeTarjetaEstandar cobrarCon: baje conOrigen: origen yDestino: destino enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana .

self assert: (baje saldoIgualA: 0*peso).
self assert: (baje sinSaldo).
! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:31:23'!
test08SiElSaldoDeLaBajeNoAlcanzaParaPagarElBoletoNoSeRealizaElViaje

|baje origen destino|.
origen := self cabeceraDel60 .
destino := self paradaPlazaDeMayo .
baje := self tarjetaBajeCon0Pesos .
self assert: (baje sinSaldo).

self
should: [self lectorDeTarjetaEstandar cobrarCon: baje conOrigen: origen yDestino: destino enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana ]
raise: Error-MessageNotUnderstood
withMessageText: Baje saldoInsuficienteDescripcionDeError.
self assert: (baje saldoIgualA: 0*peso).

! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:32:16'!
test09ElSaldoDeUnaTarjetaBajeDisminuye1300PesosAlViajarDesdeBelgranoAConstitucion

|baje origen destino|.
origen := self paradaBelgrano .
destino := self cabeceraDel60 .
baje := self tarjetaBajeCon2000Pesos .

self lectorDeTarjetaEstandar cobrarCon: baje conOrigen: origen yDestino: destino enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana .

self assert: (baje saldoIgualA: 700*peso).

! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:00:20'!
test10NoSePuedeViajarAParadasDeUnMedioDeTransporteDistinto

|baje|.

baje := self tarjetaBajeCon2000Pesos .

self
should: [
self lectorDeTarjetaEstandar cobrarCon: baje conOrigen: self paradaRetiroTrenMitre yDestino: self cabeceraDel60 enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana]
raise: Error-MessageNotUnderstood 
withMessageText: LectorDeTarjeta paradaNoPerteneceALaLineaSolicitada.

self assert: (baje saldoIgualA: 2000*peso).

! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:00:30'!
test11UnViajeEnColectivoConBajeConDescuentoEstudiantilCobraEl50PorcientoMenosLosDiasDeSemana

|baje|.

baje := self tarjetaBajeCon1000PesosConDescuentoEstudiantil .

self lectorDeTarjetaEstandar cobrarCon: baje conOrigen: self cabeceraDel60 yDestino: self paradaPlazaDeMayo enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana .

self assert: (baje saldoIgualA: 700*peso).

! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:00:38'!
test12UnViajeEnColectivoConBajeConDescuentoEstudiantilNoTieneDescuentoLosFinesDeSemana

|baje|.

baje := self tarjetaBajeCon1000PesosConDescuentoEstudiantil .

self lectorDeTarjetaEstandar cobrarCon: baje conOrigen: self cabeceraDel60 yDestino: self paradaPlazaDeMayo enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeFinDeSemana .

self assert: (baje saldoIgualA: 400*peso).

! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:01:01'!
test13UnViajeEnColectivoConBajeConDescuentoDeJubiladoTieneDosViajesGratisPorDia

|baje|.

baje := self tarjetaBajeCon1000PesosConDescuentoDeJubilado .

self lectorDeTarjetaEstandar cobrarCon: baje conOrigen: self cabeceraDel60 yDestino: self paradaPlazaDeMayo enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana .

self assert: (baje saldoIgualA: 1000*peso).


! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:01:12'!
test14UnViajeEnColectivoConBajeConDescuentoDeJubiladoTieneDosViajesGratisPorDiaYDelRestoDeBoletosAbonaSuTotalidad

|baje lectorDeTarjeta|.

baje := self tarjetaBajeCon1000PesosConDescuentoDeJubilado .
lectorDeTarjeta := self lectorDeTarjetaEstandar.
2 timesRepeat: [lectorDeTarjeta cobrarCon: baje conOrigen: self cabeceraDel60 yDestino: self paradaPlazaDeMayo enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana] .

self assert: (baje saldoIgualA: 1000*peso).

lectorDeTarjeta cobrarCon: baje conOrigen: self cabeceraDel60 yDestino: self paradaPlazaDeMayo enMedioDeTransporte: self colectivoLinea60 enDia: self fechaDeDiaDeSemana .
self assert: (baje saldoIgualA: 400*peso).



! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:01:22'!
test15UnViajeEnSubteSaleMilPesosSiempre

|baje molinete |.

baje := self tarjetaBajeCon2000Pesos .
molinete := self lectorDeTarjetaEstandar.
molinete cobrarCon: baje conOrigen: self paradaCallao yDestino: self subteDFinDeRecorrido enMedioDeTransporte: self subteLineaD enDia: self fechaDeFinDeSemana .
self assert: (baje saldoIgualA: 1000*peso).

molinete cobrarCon: baje conOrigen: self paradaCallao yDestino: self paradaPalermo enMedioDeTransporte: self subteLineaD enDia: self fechaDeDiaDeSemana .

self assert: (baje saldoIgualA: 0*peso)



! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:01:29'!
test16NoSePuedeViajarEnSubteHaciaUnaDireccionQueNoPerteneceAlRamal

|baje molinete |.

baje := self tarjetaBajeCon2000Pesos .
molinete := self lectorDeTarjetaEstandar.

self should: [molinete cobrarCon: baje conOrigen: self paradaBelgrano yDestino: self paradaPalermo enMedioDeTransporte: self subteLineaD enDia: self fechaDeDiaDeSemana]
raise: Error-MessageNotUnderstood 
withMessageText: LectorDeTarjeta paradaNoPerteneceALaLineaSolicitada.

self assert: (baje saldoIgualA: 2000*peso).




! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:02:40'!
test17TomarseElTrenMitreDesdeRetiroASanIsidroTieneUnCostoDe600Pesos

|baje molinete |.

baje := self tarjetaBajeCon1000Pesos .
molinete :=  self lectorDeTarjetaDeEntradaYSalida.

molinete cobrarCon: baje conOrigen: self estacionRetiro yDestino: self estacionSanIsidro enMedioDeTransporte: self trenMitreRamalRetiroTigre enDia: self fechaDeDiaDeSemana .

self assert: (baje saldoIgualA: 400*peso).




! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:02:58'!
test18TomarseElTrenMitreDesdeRetiroABelgranoTieneUnCostoDe600PesosSiNoSeApoyaLaTarjetaAlSalir

|baje molinete |.

baje := self tarjetaBajeCon1000Pesos .
molinete := self lectorDeTarjetaDeEntradaYSalida.

molinete cobrarCon: baje conOrigen: self estacionRetiro yDestino: self estacionBelgrano enMedioDeTransporte: self trenMitreRamalRetiroTigre enDia: self fechaDeDiaDeSemana .

self assert: (baje saldoIgualA: 400*peso).




! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:26:54'!
test19TomarseElTrenMitreDesdeRetiroABelgranoTieneUnCostoDe400PesosSiSeApoyaLaTarjetaAlSalir

|baje molinete |.

baje := self tarjetaBajeCon1000Pesos .
molinete := self lectorDeTarjetaDeEntradaYSalida.
molinete cobrarCon: baje conOrigen: self estacionRetiro yDestino: self estacionBelgrano enMedioDeTransporte: self trenMitreRamalRetiroTigre enDia: self fechaDeDiaDeSemana .

molinete marcarSalidaDe: baje.
self assert: (baje saldoIgualA: 600*peso).




! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:40:47'!
test20TomarseElTrenMitreDesdeRetiroASanIsidroTieneUnCostoDe600PesosAunqueSeApoyeLaTarjetaAlSalir

|baje molinete |.

baje := self tarjetaBajeCon1000Pesos .
molinete :=  self lectorDeTarjetaDeEntradaYSalida.

molinete cobrarCon: baje conOrigen: self estacionRetiro yDestino: self estacionSanIsidro enMedioDeTransporte: self trenMitreRamalRetiroTigre enDia: self fechaDeDiaDeSemana .

self assert: (baje saldoIgualA: 400*peso).




! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'VS 11/25/2025 21:43:21'!
test21NoSePuedeCargarLaBajeConSaldoNegativo

|baje|.

baje := Baje new.
self
should: [baje cargar: -1]
raise: Error-MessageNotUnderstood
withMessageText: Baje elSaldoACargarDebeSerPositivoDescripcionDeError! !


!ISWMetropolitanoTest methodsFor: 'tarifarios' stamp: 'VS 11/25/2025 21:39:34'!
tarifarioColectivo

|tarifario|.

tarifario := Dictionary new.

tarifario at: (5*kilometer) put: 600*peso.
tarifario at: (10*kilometer) put: 1000*peso.
tarifario at: (11*kilometer) put: 1300*peso.

^tarifario! !

!ISWMetropolitanoTest methodsFor: 'tarifarios' stamp: 'VS 11/25/2025 21:35:35'!
tarifarioSubte

^1000*peso! !

!ISWMetropolitanoTest methodsFor: 'tarifarios' stamp: 'VS 11/25/2025 21:39:52'!
tarifarioTren

|tarifario|.

tarifario := Dictionary new.

tarifario at: (15*kilometer)put: 400*peso.
tarifario at: (16*kilometer) put: 600*peso.

^tarifario! !


!ISWMetropolitanoTest methodsFor: 'paradas de colectivo' stamp: 'VS 11/25/2025 19:48:50'!
cabeceraDel60

 

^Parada conNombre: 'Constitución' distanciaDeLaCabecera: (0*kilometer)! !

!ISWMetropolitanoTest methodsFor: 'paradas de colectivo' stamp: 'VS 11/25/2025 19:48:56'!
paradaBelgrano

 

^Parada conNombre: 'Belgrano' distanciaDeLaCabecera: (12*kilometer)! !

!ISWMetropolitanoTest methodsFor: 'paradas de colectivo' stamp: 'VS 11/25/2025 19:49:01'!
paradaPlazaDeMayo



^Parada conNombre: 'Plaza de Mayo' distanciaDeLaCabecera: (5*kilometer)! !

!ISWMetropolitanoTest methodsFor: 'paradas de colectivo' stamp: 'VS 11/25/2025 19:49:05'!
paradaRetiro


^Parada conNombre: 'Retiro' distanciaDeLaCabecera: (8*kilometer)! !

!ISWMetropolitanoTest methodsFor: 'paradas de colectivo' stamp: 'VS 11/25/2025 18:23:17'!
paradaRetiroTrenMitre


^Parada conNombre: 'Retiro' distanciaDeLaCabecera: 0*kilometer! !


!ISWMetropolitanoTest methodsFor: 'fechas' stamp: 'VS 11/25/2025 18:46:15'!
fechaDeDiaDeSemana

^GregorianDateTime date: (FixedGregorianDate yearNumber: 25  monthNumber: 11  dayNumber: 25) timeOfDay: (TimeOfDay hours: 10 )! !

!ISWMetropolitanoTest methodsFor: 'fechas' stamp: 'VS 11/25/2025 18:47:56'!
fechaDeFinDeSemana

^GregorianDateTime date: (FixedGregorianDate yearNumber: 25  monthNumber: 11  dayNumber: 23) timeOfDay: (TimeOfDay hours: 10 )! !


!ISWMetropolitanoTest methodsFor: 'estaciones de tren' stamp: 'VS 11/25/2025 20:24:33'!
estacionBelgrano

^Parada conNombre: 'Estacion Belgrano' distanciaDeLaCabecera: (8*kilometer)! !

!ISWMetropolitanoTest methodsFor: 'estaciones de tren' stamp: 'VS 11/25/2025 20:24:37'!
estacionRetiro

^Parada conNombre: 'Estacion Retiro' distanciaDeLaCabecera: (0*kilometer)! !

!ISWMetropolitanoTest methodsFor: 'estaciones de tren' stamp: 'VS 11/25/2025 20:24:41'!
estacionSanIsidro

^Parada conNombre: 'Estacion San Isidro' distanciaDeLaCabecera: (18*kilometer)! !

!ISWMetropolitanoTest methodsFor: 'estaciones de tren' stamp: 'VS 11/25/2025 20:24:45'!
estacionTigre

^Parada conNombre: 'Estacion Tigre' distanciaDeLaCabecera: (28*kilometer)! !


!ISWMetropolitanoTest methodsFor: 'estaciones de subte' stamp: 'VS 11/25/2025 19:30:28'!
paradaCallao


^Parada conNombre: 'Callao' distanciaDeLaCabecera: (2.5*kilometer).
! !

!ISWMetropolitanoTest methodsFor: 'estaciones de subte' stamp: 'VS 11/25/2025 19:30:33'!
paradaCongresoDeTucuman


^Parada conNombre: 'Congreso de Tucumán' distanciaDeLaCabecera: (0*kilometer).
! !

!ISWMetropolitanoTest methodsFor: 'estaciones de subte' stamp: 'VS 11/25/2025 19:30:14'!
paradaPalermo


^Parada conNombre: 'Palermo' distanciaDeLaCabecera: (6*kilometer).
! !

!ISWMetropolitanoTest methodsFor: 'estaciones de subte' stamp: 'VS 11/25/2025 19:30:54'!
paradaTribunales


^Parada conNombre: 'Tribunales' distanciaDeLaCabecera: (1.2*kilometer).
! !

!ISWMetropolitanoTest methodsFor: 'estaciones de subte' stamp: 'VS 11/25/2025 19:56:35'!
subteDFinDeRecorrido

^self paradaPalermo! !


!ISWMetropolitanoTest methodsFor: 'medios de trasporte' stamp: 'VS 11/25/2025 21:37:47'!
colectivoLinea60

|paradas|.

paradas := OrderedCollection new.

paradas add: self cabeceraDel60 ; add: self paradaBelgrano ; add: self paradaPlazaDeMayo ; add: self paradaRetiro .

^Colectivo conParadas: paradas yTarifario: self tarifarioColectivo ! !

!ISWMetropolitanoTest methodsFor: 'medios de trasporte' stamp: 'VS 11/25/2025 21:37:55'!
colectivoLinea60ConRecorridoAcortado

|paradas|.

paradas := OrderedCollection new.

paradas add: self cabeceraDel60 .

^Colectivo conParadas: paradas yTarifario: self tarifarioColectivo ! !

!ISWMetropolitanoTest methodsFor: 'medios de trasporte' stamp: 'VS 11/25/2025 21:38:05'!
subteLineaD

|paradas|.

paradas := OrderedCollection new.

paradas add: self paradaCallao ; add: self paradaTribunales ; add: self paradaPalermo ; add: self paradaCongresoDeTucuman .

^Subte conParadas: paradas yTarifario: self tarifarioSubte ! !

!ISWMetropolitanoTest methodsFor: 'medios de trasporte' stamp: 'VS 11/25/2025 21:38:13'!
trenMitreRamalRetiroTigre

|paradas|.

paradas := OrderedCollection new.

paradas add: self estacionBelgrano ; add: self estacionSanIsidro ; add: self estacionTigre ; add: self estacionRetiro .

^Tren conParadas: paradas yTarifario: self tarifarioTren! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 122 108 110 124 117 107 118 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 122 108 110 124 117 107 118 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 60 53 56 60 53 55 52 56 58 64 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 149 31 220 17 56 55 53 56 59 57 53 57 59 53 57 56 58 17 125 104 115 108 117 123 112 117 104 52 80 117 122 119 112 121 118 117 52 56 60 52 58 60 56 56 17 125 104 115 108 117 123 112 117 104 52 80 117 122 119 112 121 118 117 52 56 60 52 58 60 56 56 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 60 91 56 62 65 56 56 65 60 58 53 60 64 59 63 57 63 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 122 108 110 124 117 107 118 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 57 107 118 87 104 121 106 112 104 115 53 122 123 17 57 57 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 60 91 57 56 65 59 62 65 58 58 53 59 57 63 55 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 122 108 110 124 117 107 118 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 57 107 118 87 104 121 106 112 104 115 53 122 123 17 58 57 56 57 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 60 91 57 56 65 59 64 65 58 57 53 62 59 61 62 56 58 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 122 108 110 124 117 107 118 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 57 107 118 87 104 121 106 112 104 115 53 122 123 17 58 56 62 64 61 17 52 52 52 52 52 52 52 52 52 52 17 17))!