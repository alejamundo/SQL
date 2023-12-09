
package config;

import java.awt.Image;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;


public class Redimencionar extends JFrame {
    private ImageIcon imagen;
    private Icon icono;
   
    //Metodo para redimencionar imagenes 
    public void redimensionarImagenes(JLabel lbl,String ruta){
        this.imagen=new ImageIcon(ruta);
        this.icono=new ImageIcon (this.imagen.getImage()
                .getScaledInstance(lbl.getWidth(), lbl.getHeight(), 
                Image.SCALE_DEFAULT));//convertir imagen en icono
        lbl.setIcon(this.icono);
        this.repaint();
    }

}
