!classDefinition: #CapturaSubmarinaTest category: #'2025-2C-1erParcial'!
TestCase subclass: #CapturaSubmarinaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'VS 10/3/2025 18:10:20'!
especimenEscurridizo

	^Especimen nuevoEspecimenEscurridizo! !

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'VS 10/3/2025 17:43:12'!
especimenPerezoso

	^Especimen nuevoEspecimenPerezoso! !


!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:08'!
test01LasSimulacionesDebenTenerEspecimenesACapturar

	self should: [ self roverConAspiradorUtilizando: self mapaVacio paradoSobre: 0@0 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception | self assert: exception messageText = RoverMarino elMapaDebeTenerEspecimenesErrorMessage ]


! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:15'!
test02ElRoverUtilizandoBrazoAspiradorEnSueloFangosoCapturaUnEspecimenPerezosoEnSuAreaDeAgarre

	|unRoverMaritimo unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 0@1.
	unRoverMaritimo := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@0.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMaritimo.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMaritimo).
	self deny: (self mapa: unMapa contiene: unEspecimenPerezoso)

	"   0 1 2 3 4
	0  x x x o o
	1  P x x o o
	2  x x x o o
	3  o o o o o
	4  o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:19'!
test03ElRoverUtilizandoBrazoAspiradorEnSueloFangosoNoCapturaUnEspecimenPerezosoFueraDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 0@1.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 0@1)

	"   0 1 2 3 4
	0  o o o o o
	1  P x x x o
	2  o x x x o
	3  o x x x o
	4  o o o o o

	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:22'!
test04ElRoverUtilizandoBrazoAspiradorEnSueloFangosoNoCapturaUnEspecimenEscurridizoQueSeMueveFueraDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@0.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 2@3)

	"   0 1 2 3 4 5               0 1 2 3 4 5
	0  o x x x o o           0  o x x x o o
	1  o x x x o o           1  o x x x o o
	2  o E x x o o   ->  2  o x x x o o
	3  o o o o o o          3  o o E o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:25'!
test05ElRoverUtilizandoBrazoAspiradorEnSueloFangosoCapturaUnEspecimenEscurridizoQueSeMueveDentroDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo)

	"   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o x x x o o           1  o x x x o o
	2  o E x x o o   ->  2  o x x x o o
	3  o x x x o o          3  o x E x o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:28'!
test06ElRoverUtilizandoBrazoAspiradorEnSueloRocosoNoCapturaUnEspecimenPerezosoEnAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 2@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@0.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 2@2)

	"   0 1 2 3 4 5
	0  x x x o o o
	1  x x x o o o
	2  o o P o o o
	3  o o o o o o
	4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:31'!
test07ElRoverUtilizandoBrazoAspiradorEnSueloRocosoCapturaUnEspecimenPerezosoEnAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 2@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@1.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenPerezoso)

      "   0 1 2 3 4 5
	0  o o o o o o
	1  x x x o o o
	2  x x P o o o
	3  o o o o o o
	4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:34'!
test08ElRoverUtilizandoBrazoAspiradorEnSueloRocosoNoCapturaUnEspecimenEscurridizoQueSeMueveFueraDeAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 2@1.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@0.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 2@2)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  x x x o o o           0  x x x o o o
	1  x x E o o o           1  x x x o o o
	2  o o o o o o   ->  2  o o E o o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:37'!
test09ElRoverUtilizandoBrazoApiradorEnSueloRocosoCapturaUnEspecimenEscurridizoQueSeMueveFueraDeAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 2@1.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@1.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo)

     "     0 1 2 3 4 5              0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  x x E o o o           1  x x x o o o
	2  x x x o o o   ->  2  x x E o o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:42'!
test10ElRoverUtilizandoBrazoRedEnSueloFangosoNoCapturaUnEspecimenPerezoso

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 0@1.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 0@1)

	"   0 1 2 3 4
	0  o o o o o
	1  P x x x o
	2  o o o o o
	3  o o o o o
	4  o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:45'!
test11ElRoverUtilizandoBrazoRedEnSueloFangosoNoCapturaUnEspecimenEscurridizoQueSeMueveFueraDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 1@2.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 0@2)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o           1  o o o o o o
	2  o E x x x o   ->  2  E x x x x o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:49'!
test12ElRoverUtilizandoBrazoRedEnSueloFangosoCapturaUnEspecimenEscurridizoQueSeMueveDentroDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: (1@2).
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o          1  o o o o o o
	2  x E x x o o   ->  2  E x x x o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:52'!
test13ElRoverUtilizandoBrazoRedEnSueloRocosoNoCapturaNingunEspecimenYRompeLaRed

	|unRoverMarino unMapa unEspecimenEscurridizo unEspecimenPerezoso |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unEspecimenPerezoso := self especimenPerezoso.

	unMapa := self mapaCon: unEspecimenEscurridizo en: 0@2 y: unEspecimenPerezoso en: 1@2.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self should: [self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:exception |
		self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
		self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
		self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 0@2).
		self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 1@2).

		self assert: exception messageText = RoverMarino brazoDañadoErrorMessage
	]

	"   0 1 2 3 4 5 6
	0  o o o o o o o
	1  o o o o o o o
	2  E P x x x x o
	3  o o o o o o o
	4  o o o o o	 o o
	"
! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:56'!
test14ElRoverCapturaTodosLosEspecimenesDentroDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo otroEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	otroEspecimenEscurridizo:= self especimenEscurridizo.

	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2 y: otroEspecimenEscurridizo en: 2@2.

	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self verificarCapturaDeEspecimen: otroEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo).
	self deny: (self mapa: unMapa contiene: otroEspecimenEscurridizo)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o          1   o o o o o o
	2  x E E x x x   ->  2  x x x o o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:59'!
test15ElRoverCapturaTodosLosEspecimenesAunSiEstanEnLaMismaPosicion

	|unRoverMarino unMapa unEspecimenEscurridizo otroEspecimenPerezoso |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	otroEspecimenPerezoso:= self especimenPerezoso.

	unMapa := self mapaCon:  unEspecimenEscurridizo en: 1@2 y: otroEspecimenPerezoso en: 2@3.

	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self verificarCapturaDeEspecimen: otroEspecimenPerezoso por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo).
	self deny: (self mapa: unMapa contiene: otroEspecimenPerezoso)

	"   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o x x x o o           1  o x x x o o
	2  o E x x o o   ->  2  o x x x o o
	3  o x P x o o          3  o x x x o o
	4  o o o o o o          4  o o o o o o
	"

	! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:01:02'!
test16ElRoverUtilizandoBrazoRedEnSueloRocosoSeRompeYCambiaAModoContingencia

	|unRoverMarino unMapa unEspecimenEscurridizo unEspecimenPerezoso |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unEspecimenPerezoso := self especimenPerezoso.

	unMapa := self mapaCon: unEspecimenEscurridizo en: 0@2 y: unEspecimenPerezoso en: 1@2.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self should: [self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:exception |
		self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
		self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
		self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 0@2).
		self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 1@2).

		self assert: exception messageText = RoverMarino brazoDañadoErrorMessage .
	].

	 "  0 1 2 3 4 5              0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o           1  o o o o o o
	2  E P x x x x   ->  2  x P x x x x
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"

	"Se hacen las capturas en modo contingencia"

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 1@2)
! !


!CapturaSubmarinaTest methodsFor: 'simulaciones' stamp: 'HAW 10/3/2025 16:30:59'!
simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: unAmbiente

	self halt: 'Implementar!!'

! !


!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'VS 10/3/2025 19:37:00'!
mapaCon: unEspecimen en: unaPosicion

|mapa|.
	mapa := Dictionary new.
	mapa at: unEspecimen put: unaPosicion .
	
	^mapa! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'VS 10/3/2025 19:37:24'!
mapaCon: unEspecimen en: unaPosicion y: otroEspecimen en: otraPosicion

|mapa|.
mapa := Dictionary new.
mapa at: unEspecimen put: unaPosicion .
mapa at: otroEspecimen put: otraPosicion .

^mapa! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'VS 10/3/2025 17:49:57'!
mapaVacio

^Dictionary new

	 ! !


!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'VS 10/3/2025 18:07:40'!
mapa: unMapa contiene: unEspecimen

	^unMapa keyAtValue: unEspecimen ifAbsent: [^false]! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'VS 10/3/2025 19:42:51'!
mapa: unMapa contiene: unEspecimen en: unPunto

^(unMapa at: unEspecimen ) = unPunto ! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'VS 10/3/2025 20:57:13'!
verificarCapturaDeEspecimen: unEspecimen por: unRover

^unRover capturoA: unEspecimen ! !


!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'VS 10/3/2025 20:42:52'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto

	^RoverMarino con: (BrazoAspirador new) utilizando: unMapa paradoSobre: unPunto! !

!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'VS 10/3/2025 20:43:00'!
roverConRedUtilizando: unMapa paradoSobre: unPunto

	^RoverMarino con: (BrazoRed new) utilizando: unMapa paradoSobre: unPunto! !


!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'VS 10/3/2025 18:46:27'!
simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRover

	^unRover intentoDeCapturaEn: unMapa conSuelo: #fangoso ! !

!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'VS 10/3/2025 18:42:20'!
simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRover

	^unRover intentoDeCapturaEn: unMapa conSuelo: #rocoso.! !


!classDefinition: #Brazo category: #'2025-2C-1erParcial'!
Object subclass: #Brazo
	instanceVariableNames: 'rover areaDeCaptura'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Brazo methodsFor: 'ver si un especimen esta en area de captura' stamp: 'VS 10/3/2025 21:39:29'!
estaEnAreaDeCaptura: unEspecimen ubicadoEn: unPunto


^((unPunto >= areaDeCaptura origin) and: (unPunto <= areaDeCaptura corner))
! !


!Brazo methodsFor: 'calcular area de captura' stamp: 'VS 10/3/2025 21:32:15'!
areaDeCapturaSobreSuelo: unTipoDeSuelo aPartirDe: unPuntoInicial 

self subclassResponsibility ! !


!Brazo methodsFor: 'capturar' stamp: 'VS 10/3/2025 21:45:07'!
intentarCapturar: unEspecimen enSuelo: unTipoDeSuelo

(unEspecimen tipo = #	escurridizo) ifTrue: [
	rover especimenSeIntentaEscurrir: unEspecimen enSuelo: unTipoDeSuelo .
	(self estaEnAreaDeCaptura: unEspecimen ubicadoEn: (rover ubicacionDeUnEspecimen: unEspecimen)) ifTrue: [rover fueCapturado: unEspecimen ] ifFalse: [^self]].


		! !


!Brazo methodsFor: 'inicializacion' stamp: 'VS 10/3/2025 20:02:01'!
en: unRoverMarino

rover := unRoverMarino ! !


!Brazo methodsFor: 'asserciones' stamp: 'VS 10/3/2025 20:58:10'!
assertPuedeCapturarEnTipoDeSuelo: unTipoDeSuelo 

self subclassResponsibility 

! !


!Brazo methodsFor: 'se escurre un especimen' stamp: 'VS 10/3/2025 21:16:31'!
trataDeEscurrirse: unEspecimenEscurridizo aPartirDe: puntoInicialDelEspecimen enTipoDeSuelo: unTipoDeSuelo .


(unTipoDeSuelo = #rocoso) ifTrue: [
	rover seEscurrio: unEspecimenEscurridizo hacia: (puntoInicialDelEspecimen + (0@1))].
! !


!classDefinition: #BrazoAspirador category: #'2025-2C-1erParcial'!
Brazo subclass: #BrazoAspirador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!BrazoAspirador methodsFor: 'calcular area de captura' stamp: 'VS 10/3/2025 21:33:35'!
areaDeCapturaSobreSuelo: unTipoDeSuelo aPartirDe: unPuntoInicial 


	(unTipoDeSuelo = #fangoso) ifTrue: [^areaDeCaptura := Rectangle origin: unPuntoInicial corner: (unPuntoInicial+(2@2))].
	(unTipoDeSuelo = #rocoso) ifTrue: [^areaDeCaptura := Rectangle origin: unPuntoInicial corner: (unPuntoInicial+ (2@1))].
! !


!BrazoAspirador methodsFor: 'capturar' stamp: 'VS 10/3/2025 20:50:33'!
intentarCapturar: unEspecimen enSuelo: unTipoDeSuelo 

super intentarCapturar: unEspecimen enSuelo: unTipoDeSuelo .

(unEspecimen tipo = #perezoso) ifTrue: [rover fueCapturado: unEspecimen ].
! !


!BrazoAspirador methodsFor: 'asserciones' stamp: 'VS 10/3/2025 20:58:24'!
assertPuedeCapturarEnTipoDeSuelo: unTipoDeSuelo

 ! !


!BrazoAspirador methodsFor: 'se escurre un especimen' stamp: 'VS 10/3/2025 21:17:32'!
trataDeEscurrirse: unEspecimenEscurridizo aPartirDe: puntoInicialDelEspecimen enTipoDeSuelo: unTipoDeSuelo

 super trataDeEscurrirse: unEspecimenEscurridizo aPartirDe:puntoInicialDelEspecimen  enTipoDeSuelo: unTipoDeSuelo .
(unTipoDeSuelo = #fangoso) ifTrue: [
	
	rover seEscurrio: unEspecimenEscurridizo hacia: (puntoInicialDelEspecimen + (1@1))] .
! !


!classDefinition: #BrazoRed category: #'2025-2C-1erParcial'!
Brazo subclass: #BrazoRed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!BrazoRed methodsFor: 'calcular area de captura' stamp: 'VS 10/3/2025 21:32:57'!
areaDeCapturaSobreSuelo: unTipoDeSuelo aPartirDe: unPuntoInicial 



	(unTipoDeSuelo = #rocoso) ifTrue: [^areaDeCaptura := Rectangle origin: unPuntoInicial corner: (unPuntoInicial +(6@0))].
	(unTipoDeSuelo = #fangoso) ifTrue:[^areaDeCaptura := Rectangle origin: unPuntoInicial corner: (unPuntoInicial +(3@0))].
	
	

 ! !


!BrazoRed methodsFor: 'romperse' stamp: 'VS 10/3/2025 20:07:49'!
romperse

rover pasarAContingencia.! !


!BrazoRed methodsFor: 'capturar' stamp: 'VS 10/3/2025 21:34:10'!
assertPuedeCapturarEnTipoDeSuelo: unTipoDeSuelo  

(unTipoDeSuelo = #rocoso) ifTrue: [self romperse].

! !

!BrazoRed methodsFor: 'capturar' stamp: 'VS 10/3/2025 20:32:14'!
intentarCapturar: unEspecimen enSuelo: unTipoDeSuelo

super intentarCapturar: unEspecimen enSuelo: unTipoDeSuelo .

(unEspecimen tipo = #perezoso) ifTrue: [
			
	(unTipoDeSuelo = #fangoso) ifTrue: [^self]].
			
! !


!BrazoRed methodsFor: 'se escurre un especimen' stamp: 'VS 10/3/2025 21:17:43'!
trataDeEscurrirse: unEspecimenEscurridizo aPartirDe: puntoInicialDelEspecimen enTipoDeSuelo: unTipoDeSuelo

super trataDeEscurrirse: unEspecimenEscurridizo aPartirDe: puntoInicialDelEspecimen enTipoDeSuelo: unTipoDeSuelo .

(unTipoDeSuelo = #fangoso) ifTrue: [
rover seEscurrio: unEspecimenEscurridizo hacia: (puntoInicialDelEspecimen + (-1@0))].
	! !


!classDefinition: #Especimen category: #'2025-2C-1erParcial'!
Object subclass: #Especimen
	instanceVariableNames: 'tipo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Especimen methodsFor: 'inicializacion' stamp: 'VS 10/3/2025 17:44:22'!
initializeConTipo: unTipoDeEspecimen
	
	tipo := unTipoDeEspecimen .! !


!Especimen methodsFor: 'accediendo' stamp: 'VS 10/3/2025 18:13:05'!
tipo
	
	^tipo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Especimen class' category: #'2025-2C-1erParcial'!
Especimen class
	instanceVariableNames: ''!

!Especimen class methodsFor: 'instance creation' stamp: 'VS 10/3/2025 18:10:39'!
nuevoEspecimenEscurridizo
	
	^self new initializeConTipo: #escurridizo! !

!Especimen class methodsFor: 'instance creation' stamp: 'VS 10/3/2025 17:43:44'!
nuevoEspecimenPerezoso
	
	
	^self new initializeConTipo: #perezoso! !


!classDefinition: #EstadoDeRoverMarino category: #'2025-2C-1erParcial'!
Object subclass: #EstadoDeRoverMarino
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!EstadoDeRoverMarino methodsFor: 'inicializacion' stamp: 'VS 10/3/2025 21:23:09'!
inicializarEn: unRoverMarino


rover := unRoverMarino .! !


!EstadoDeRoverMarino methodsFor: 'capturar' stamp: 'VS 10/3/2025 21:29:12'!
capturarEspecimenesEnTipoDeSuelo: unTipoDeSuelo

self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoDeRoverMarino class' category: #'2025-2C-1erParcial'!
EstadoDeRoverMarino class
	instanceVariableNames: ''!

!EstadoDeRoverMarino class methodsFor: 'as yet unclassified' stamp: 'VS 10/3/2025 21:30:55'!
en: unRoverMarino

^self new inicializarEn: unRoverMarino ! !


!classDefinition: #CapturaConBrazo category: #'2025-2C-1erParcial'!
EstadoDeRoverMarino subclass: #CapturaConBrazo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!CapturaConBrazo methodsFor: 'capturar' stamp: 'VS 10/3/2025 21:29:32'!
capturarEspecimenesEnTipoDeSuelo: unTipoDeSuelo

rover capturarConBrazoEnTipoDeSuelo: unTipoDeSuelo ! !


!classDefinition: #EnContingencia category: #'2025-2C-1erParcial'!
EstadoDeRoverMarino subclass: #EnContingencia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!EnContingencia methodsFor: 'capturar' stamp: 'VS 10/3/2025 21:29:47'!
capturarEspecimenesEnTipoDeSuelo: unTipoDeSuelo

rover capturarEnContingenciaEnTipoDeSuelo: unTipoDeSuelo ! !


!classDefinition: #RoverMarino category: #'2025-2C-1erParcial'!
Object subclass: #RoverMarino
	instanceVariableNames: 'mapa puntoInicial bioBox brazo estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!RoverMarino methodsFor: 'inicializacion' stamp: 'VS 10/3/2025 21:23:51'!
initializeCon: unBrazo utilizando: unMapa paradoSobre: unPunto 
	
	mapa := unMapa.
	puntoInicial := unPunto.
	bioBox := OrderedCollection new.
	brazo := unBrazo en: self.
	estado := CapturaConBrazo en: self.! !


!RoverMarino methodsFor: 'actualizar mapa' stamp: 'VS 10/3/2025 20:54:56'!
actualizarMapa: unMapa conLaCapturaDe: unEspecimen

	^ unMapa removeKey: unEspecimen ! !


!RoverMarino methodsFor: 'capturando' stamp: 'VS 10/3/2025 21:42:06'!
capturarConBrazoEnTipoDeSuelo: unTipoDeSuelo


	 brazo areaDeCapturaSobreSuelo: unTipoDeSuelo aPartirDe: puntoInicial . 
	brazo assertPuedeCapturarEnTipoDeSuelo: unTipoDeSuelo .

(self especimenesEnMapa: mapa) do: [:unEspecimen|
	(brazo estaEnAreaDeCaptura: unEspecimen ubicadoEn: (mapa at: unEspecimen )) ifTrue: [
	brazo intentarCapturar: unEspecimen enSuelo: unTipoDeSuelo  ]].
! !

!RoverMarino methodsFor: 'capturando' stamp: 'VS 10/3/2025 21:28:17'!
capturarEnContingenciaEnTipoDeSuelo: unTipoDeSuelo


		(self especimenesEnMapa: mapa) do: [:unEspecimen |
			(unEspecimen tipo = #perezoso) ifFalse: [
			self fueCapturado: unEspecimen ].
		].
	! !

!RoverMarino methodsFor: 'capturando' stamp: 'VS 10/3/2025 20:54:56'!
fueCapturado: unEspecimen

bioBox add: unEspecimen . 
self actualizarMapa: mapa conLaCapturaDe: unEspecimen .
! !

!RoverMarino methodsFor: 'capturando' stamp: 'VS 10/3/2025 21:28:47'!
intentoDeCapturaEn: unMapa conSuelo: unTipoDeSuelo  
	
	estado capturarEspecimenesEnTipoDeSuelo: unTipoDeSuelo .
	! !


!RoverMarino methodsFor: 'accediendo' stamp: 'VS 10/3/2025 20:57:13'!
capturoA: unEspecimen 
	^bioBox includes: unEspecimen ! !

!RoverMarino methodsFor: 'accediendo' stamp: 'VS 10/3/2025 19:38:08'!
especimenesEnMapa: unMapa

	^ unMapa keys! !

!RoverMarino methodsFor: 'accediendo' stamp: 'VS 10/3/2025 21:44:27'!
ubicacionDeUnEspecimen: unEspecimen

^(mapa at: unEspecimen )! !


!RoverMarino methodsFor: 'especimen se escurre' stamp: 'VS 10/3/2025 21:18:41'!
especimenSeIntentaEscurrir: unEspecimen enSuelo: unTipoDeSuelo   

|puntoInicialDelEspecimen|.
puntoInicialDelEspecimen := (mapa at: unEspecimen ).

brazo trataDeEscurrirse: unEspecimen aPartirDe:  puntoInicialDelEspecimen enTipoDeSuelo: unTipoDeSuelo 



! !

!RoverMarino methodsFor: 'especimen se escurre' stamp: 'VS 10/3/2025 20:39:59'!
seEscurrio: unEspecimenEscurridizo hacia: unPunto

mapa at: unEspecimenEscurridizo put: unPunto .! !


!RoverMarino methodsFor: 'cambiando estado' stamp: 'VS 10/3/2025 21:25:55'!
pasarAContingencia

estado := EnContingencia en: self.
self error: self class brazoDañadoErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverMarino class' category: #'2025-2C-1erParcial'!
RoverMarino class
	instanceVariableNames: ''!

!RoverMarino class methodsFor: 'error messages' stamp: 'NR 10/3/2025 06:08:53'!
brazoDañadoErrorMessage

	^ 'El brazo se ha dañado. Imposible capturar' ! !

!RoverMarino class methodsFor: 'error messages' stamp: 'NR 10/3/2025 06:08:35'!
elMapaDebeTenerEspecimenesErrorMessage

	^ 'El mapa debe tener al menos un especimen para capturar'! !


!RoverMarino class methodsFor: 'instance creation' stamp: 'VS 10/3/2025 20:42:13'!
con: unBrazo utilizando: unMapa paradoSobre: unPunto 
	
	self assertMapaTieneEspecimenesMarinos: unMapa .
	^self new initializeCon: unBrazo utilizando: unMapa paradoSobre: unPunto! !


!RoverMarino class methodsFor: 'asserts' stamp: 'VS 10/3/2025 17:51:15'!
assertMapaTieneEspecimenesMarinos: unMapa 
	
	(unMapa isEmpty) ifTrue: [self error: self elMapaDebeTenerEspecimenesErrorMessage ]! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 61 58 60 55 53 112 116 104 110 108 17 124 117 112 127 17 115 112 117 124 127 52 110 117 124 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 39 62 39 84 104 121 106 111 39 57 55 57 58 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 63 39 57 55 57 58 39 55 57 65 57 58 65 60 55 39 74 118 116 119 112 115 108 121 65 39 74 115 104 117 110 39 64 53 55 53 55 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 64 55 55 54 109 112 117 104 115 48 17 78 108 117 108 121 104 123 108 107 39 118 117 39 130 62 39 84 104 121 106 111 39 57 55 57 58 39 53 39 56 56 65 56 61 65 55 63 39 119 116 132 53 39 74 118 116 119 112 115 108 107 39 118 117 39 84 104 121 39 39 63 39 57 55 57 58 17 78 108 117 108 121 104 123 108 107 39 118 117 39 130 62 39 84 104 121 106 111 39 57 55 57 58 39 53 39 56 56 65 56 61 65 56 61 39 119 116 132 53 39 74 118 116 119 112 115 108 107 39 118 117 39 84 104 121 39 39 63 39 57 55 57 58 17 93 84 65 39 57 55 57 58 55 58 55 63 55 57 56 63 39 121 124 117 117 108 121 71 109 125 52 104 129 57 61 56 52 61 56 58 65 126 118 121 114 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 91 124 108 39 84 104 121 39 62 39 57 58 65 56 63 65 59 61 39 57 55 57 58 39 74 118 116 116 112 123 79 104 122 111 65 39 104 61 58 107 55 105 55 39 87 115 124 110 112 117 122 65 39 57 55 57 58 55 58 55 63 55 57 56 63 39 121 124 117 117 108 121 71 109 125 52 104 129 57 61 56 52 61 56 58 65 126 118 121 114 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 149 33 11 17 56 55 53 56 59 57 53 57 61 53 59 17 125 104 115 108 117 123 112 117 104 52 80 117 122 119 112 121 118 117 52 56 60 52 58 60 56 56 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 58 91 56 62 65 58 56 65 60 62 53 64 62 62 55 58 64 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 56 62 63 63 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 58 91 56 64 65 60 63 65 60 58 53 62 57 58 62 60 60 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 59 60 55 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 58 91 57 56 65 58 55 65 57 63 53 58 63 63 56 60 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 55 56 64 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 58 91 57 56 65 59 57 65 58 57 53 57 59 64 61 59 60 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 63 62 55 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 58 91 57 56 65 59 60 65 56 63 53 63 62 55 60 61 61 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 63 63 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 58 91 57 56 65 59 61 65 56 61 53 58 55 61 55 63 61 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 63 61 56 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 58 91 57 56 65 59 62 65 60 55 53 60 57 56 63 57 63 52 55 58 65 55 55 17 54 111 118 116 108 54 125 104 115 108 117 123 112 117 104 54 75 108 122 106 104 121 110 104 122 54 106 124 112 122 119 104 121 106 112 104 115 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 63 61 56 56 17 52 52 52 52 52 52 52 52 52 52 17 17))!