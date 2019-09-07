# PRTL
A framework for the analysis of transient overvoltage in overhead lines and underground cables due to lightning. This work is dedicated to the memory of Professor Carlos Portela, a great inspiration regarding the transient analysis of electrical systems, a great mentor and a much-missed friend and colleague.

An effective analysis and design of an overhead line demands and accurate and numerically efficient algorithm to evaluate its lightning performance. Furthermore, the frequency dependent in overhead conductors and tower grounding systems is paramount. Traditionally, one may use either frequency-domain or time-domain for the network solution. There are advantages and limitations in either approaches.

Regardless of the domain choice, most programs (commercial or not) used for lightning performance have a common feature, they are closed source/architecture, i.e., one is limited to a set of built-in models and with a limited option to develop/test new models or unusual configurations.

This work presents an open framework for the lightning performance of overhead transmission line and was named PRTL after late professor Carlos Portela. It is based on the computed document format (CDF) using the Wolfram Language which has a CDF-player freely available. In this format, the code for each configuration considered is completely open-source. Thus, all models and the actual network solving structure are also open-sourced, allowing the technical community to test them fully.

The theory behind the PRTL can be found in the paper "An Open Framework for Lightning Performance of Overhead Transmission Lines" by A.C. S. Lima, Robson F. S. Dias, Karen Salim and Maria Teresa Correia de Barros presented in XIV SIPDA in Oct. 2017. 

Futher development of the PRTL framework includes the possibility of accurately represent the grounding systems of overhead lines. This particular application received the name PRTL-mHEM or only mHEM (Modified Hybrid Electromagnetic Model) and is described in the paper "A Computational Improvement in Grounding Systems Transient Analysis" by A. C. S. Lima, R. A. R. Moura, P. H. N. Vieira, M. A. O. Schroeder, and M. T. Correia de Barros, to be published in IEEE Trans. on Electromagnetic Compatibility.  
